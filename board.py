from flask import (Flask, jsonify, render_template, redirect, request, flash,
                   session)

from model import (User, BoardUser, Board, Genre, Square, SquareUser, Book, 
                   BookGenre, connect_to_db, db)

from goodreads import (create_url, url_to_dict, get_title, get_author, 
                        get_image_url, get_goodreads_id, get_description)

from sqlalchemy.orm.exc import NoResultFound

import plotly.graph_objs as go


def register_new_user():
    """Add new user to database"""

    email = request.form.get("email")

    password = request.form.get("password")

    first_name = request.form.get("f-name")

    last_name = request.form.get("l-name")

    new_user = User(email=email,
                    password=password,
                    first_name=first_name,
                    last_name=last_name)

    db.session.add(new_user)

    db.session.commit()

    user_id = db.session.query(User).filter_by(email=email).one().user_id

    session['user_id'] = user_id
    flash("Logged in!")

    return user_id

def user_login():
    """Log in existing user"""

    email = request.form.get("email")

    password = request.form.get("password")

    try:
        db.session.query(User).filter_by(email=email).one().email
        password == db.session.query(User).filter_by(email=email).one().password
    except NoResultFound:
        flash("Login information inccorect")
        return redirect("/login")

    user_id = db.session.query(User).filter_by(email=email).one().user_id


    session['user_id'] = user_id
    flash("Logged in!")

    return user_id

def get_user_boards(user_id):
    """Get users's boards to display on homepage"""

    user_boards = db.session.query(User).filter_by(user_id=user_id).one().boards 

    boards = []

    for board in user_boards:
        board_name = board.board_name
        board_id = board.board_id
        boards.append((board_name, board_id))

    return boards


def create_new_board():
    """Create new board"""

    # Initialize new board object
    board_name = request.form.get("board-name")

    new_board = Board(board_name=board_name)

    return new_board


def add_user_to_board(board):
    """Add user to board and assign genres"""

    #get user_id from the session
    user_id = session["user_id"]

    #get user object
    user = User.query.get(user_id)

     # Append user to board 
    board.users.append(user)

    # Get board genres from HTML Form
    genres_text = []

    for i in range(25):
        if i == 12:
            genres_text.append("FREE SQUARE")
        genres_text.append(request.form.get("genre" + str(i+1)))

    return genres_text


def create_genres(genre_lst):
    """Instantiate genre objects"""

    genre_objects = []

    for genre_text in genre_lst:
        genre_objects.append(Genre(name=genre_text))

    return genre_objects


def create_squares(board, genre_objects):
    """Create squares for the board"""

    squares = []

    coordinate_list = [(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (2, 1), (2, 2), 
    (2, 3), (2, 4), (2, 5),(3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (4, 1), 
    (4, 2), (4, 3), (4, 4), (4, 5), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5)]
    
    for coordinate in coordinate_list:
        squares.append(Square(x_coord=coordinate[0], y_coord=coordinate[1]))


    #Append squares to board and assign genres

    for i in range(len(squares)):
        square = squares[i]
        genre_object = genre_objects[i]
        square.genre = genre_object
        board.squares.append(square) 

    return squares


def update_database():
    """Get information from HTML forms, create SquareUser object, and update database"""

    user_id = session["user_id"]

    user_object = User.query.get(user_id)

    square_id = request.form.get("square_id")

    square_object = Square.query.get(square_id)

    title = request.form.get("book")

    author = request.form.get("author")

    x_coord = request.form.get("x_coord")

    y_coord = request.form.get("y_coord")

    genre_id = db.session.query(Square).filter_by(square_id=square_id).one().genre_id

    genre_object = Genre.query.get(genre_id)

    board_id = db.session.query(Square).filter_by(square_id=square_id).one().board_id

    # Add new book to the DB, if it does not already exist in the DB

    try:
        new_book = db.session.query(Book).filter_by(title=title, author=author).one()
    except NoResultFound:
        new_book = Book(title=title, author=author)
        new_book.genres.append(genre_object)

        book_url = create_url(title)

        response_dict = url_to_dict(book_url)

        goodreads_id = get_goodreads_id(response_dict)

        book_image = get_image_url(response_dict)

        book_description = get_description(goodreads_id)

        new_book.goodreads_id = goodreads_id

        new_book.image_url = book_image

        new_book.description = book_description

    # Bring user, book, and square together in DB

    new_Sqaureuser = SquareUser()

    new_Sqaureuser.user = user_object
    new_Sqaureuser.square = square_object
    new_Sqaureuser.book = new_book

    db.session.add(new_Sqaureuser)

    db.session.commit()

    print "Commit: Book title %s Author %s Square_ID %s Board ID %s" % (title, author, square_id, board_id)



def connect_to_goodreads():
    """Connect to Goodreads API"""

    book_title = request.form.get("book")
    square_id = request.form.get("square_id")
    x_coord = request.form.get("x_coord")
    y_coord = request.form.get("y_coord")

    book_url = create_url(book_title)

    response_dict = url_to_dict(book_url)

    title = get_title(response_dict)


    if title:

        author = get_author(response_dict)

        book_image = get_image_url(response_dict)


    # Send data back to Ajax call success function 

    book_data = {'title': title, 
                'square_id': square_id,
                'author': author,
                'book_image': book_image,
                'x_coord': x_coord,
                'y_coord': y_coord
                }

    return book_data

def get_user_data_for_board(board_id):
    """Finds out which users have read how many books on a given board. Returns data as
    a list of tuples. Example:
    [(user_id, first_name, number_of_books)]"""

    board_users_data = db.session.query(SquareUser.user_id, User.first_name, db.func.count(SquareUser.squ_id)).filter(BoardUser.board_id == board_id).join(BoardUser, SquareUser.user_id == BoardUser.user_id).join(User, SquareUser.user_id == User.user_id).group_by(SquareUser.user_id, User.first_name).all()

    return board_users_data


