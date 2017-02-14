"""Book Bingo"""

from jinja2 import StrictUndefined

from flask import (Flask, jsonify, render_template, redirect, request, flash,
                   session)
from flask_debugtoolbar import DebugToolbarExtension

from model import (User, BoardUser, Board, Genre, Square, SquareUser, Book, 
                   BookGenre, connect_to_db, db)

from goodreads import (create_url, url_to_dict, get_title, get_author, 
                        get_image_url, get_goodreads_id, get_description)

from sqlalchemy.orm.exc import NoResultFound

import json



app = Flask(__name__)

app.secret_key = "ks3sn4kynsna87d6f5"

app.jinja_env.undefined = StrictUndefined



@app.route('/')
def index():
    """Homepage"""

    return render_template("homepage.html")


@app.route('/login', methods=["GET"])
def login_form():
    """Render login form"""

    return render_template("login.html")


@app.route('/login', methods=["POST"])
def login_process():
    """Execute login process"""

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

    return redirect("/users/" + str(user_id))

@app.route('/register', methods=["GET"])
def register_form():
    """Render registration form"""

    return render_template("register.html")


@app.route('/register', methods=["POST"])
def register_process():
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

    session['user_id'] = user_id
    flash("Logged in!")

    return redirect("/")


@app.route('/logout', methods=["GET"])
def logout():
    """Render logout form"""

    return render_template("logout.html")


@app.route('/logout', methods=["POST"])
def logout_complete():
    """Implement user logout"""

    del session["user_id"]
    flash("Logged out!")

    return redirect("/")


@app.route('/users/<user_id>')
def display_user(user_id):
    """User homepage"""

    first_name = db.session.query(User).filter_by(user_id=user_id).one().first_name

    user_boards = db.session.query(User).filter_by(user_id=user_id).one().boards 

    boards = []

    for board in user_boards:
        board_name = board.board_name
        board_id = board.board_id
        boards.append(board_name)

    return render_template("user_details.html",
                    first_name=first_name,
                    board_id=board_id,
                    boards=boards)


@app.route('/create-board', methods=["GET"])
def board_form():
    """Displays form allowing user to create new board"""

    if "user_id" in session:
        return render_template('new_board.html')
    else:
        flash("Please log in to create a board.")
        return redirect("/login")


@app.route('/create-board', methods=["POST"])
def create_board():
    """Populates the board with user data and redirects the user to it"""

    #get user_id from the session
    user_id = session["user_id"]

    #get user object
    user = User.query.get(user_id)

    # Initialize new board object
    board_name = request.form.get("board-name")

    new_board = Board(board_name=board_name)

    # Append user to board 
    new_board.users.append(user)

    # Get board genres from HTML Form
    genres_text = []

    for i in range(25):
        if i == 12:
            genres_text.append("FREE SQUARE")
        genres_text.append(request.form.get("genre" + str(i+1)))

    
    # Instantiate genre objects
    genre_objects = []

    for genre_text in genres_text:
        genre_objects.append(Genre(name=genre_text))


    # Create squares
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
        new_board.squares.append(square) 
    
    db.session.add(new_board)
    db.session.commit()


    # get new board ID from DB
    board_id = new_board.board_id

    return redirect('/board/' + str(board_id))


@app.route('/board/<board_id>', methods=["GET"])
def display_board(board_id):
    """Displays bingo board using information from database"""

    user_id = session["user_id"]

    this_board = Board.query.get(board_id)
    book_info = this_board.get_squares(user_id)

    # Splits all genres into rows of 5    
    row1 = book_info[:5]
    row2 = book_info[5:10]
    row3 = book_info[10:15]
    row4 = book_info[15:20]
    row5 = book_info[20:]

    # Creates lists of rows 
    board_rows = [row1, row2, row3, row4, row5]


    return render_template("board.html",
                            board_rows=board_rows)


@app.route('/update-board.json', methods=["POST"])
def process_submission():

    user_id = session["user_id"]

    user_object = User.query.get(user_id)

    square_id = request.form.get("square_id")

    square_object = Square.query.get(square_id)

    title = request.form.get("book")

    author = request.form.get("author")

    genre_id = db.session.query(Square).filter_by(square_id=square_id).one().genre_id

    genre_object = Genre.query.get(genre_id)

    board_id = db.session.query(Square).filter_by(square_id=square_id).one().board_id


    print "Book title %s Author %s Square_ID %s User %s Genre ID %s Board ID %s" % (title, author, square_id, user_id, genre_id, board_id)


    # Add new book to the DB

    new_book = Book(title=title, author=author)
    new_book.genres.append(genre_object)

    # Bring user, book, and square together in DB

    new_Sqaureuser = SquareUser()

    new_Sqaureuser.user = user_object
    new_Sqaureuser.square = square_object
    new_Sqaureuser.book = new_book

    db.session.add(new_Sqaureuser)

    db.session.commit()

    # API Calls

    book_url = create_url(title)

    response_dict = url_to_dict(book_url)

    book_title = get_title(response_dict)

    book_author = get_author(response_dict)

    book_image = get_image_url(response_dict)

    goodreads_id = get_goodreads_id(response_dict)

    book_description = get_description(goodreads_id)


    # Send data back to Ajax call success function 

    book_data = {'title': title, 
                'square_id': square_id,
                'author': author,
                'book_description': book_description
                }

    return jsonify(book_data)

if __name__ == "__main__":

    app.debug = True
    app.jinja_env.auto_reload = app.debug  # make sure templates, etc. are not cached in debug mode

    connect_to_db(app)

    # Use the DebugToolbar
    DebugToolbarExtension(app)


    
    app.run(port=5000, host='0.0.0.0')