"""Book Bingo"""

from jinja2 import StrictUndefined

from flask import (Flask, jsonify, render_template, redirect, request, flash,
                   session)
from flask_debugtoolbar import DebugToolbarExtension

from model import (User, BoardUser, Board, Genre, Square, SquareUser, Book, 
                   BookGenre, connect_to_db, db)

from sqlalchemy.orm.exc import NoResultFound



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
                    boards=boards,
                    board_name=board_name)


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
    genre1_name = request.form.get("genre1")
    genre2_name = request.form.get("genre2")
    genre3_name = request.form.get("genre3")
    genre4_name = request.form.get("genre4")
    genre5_name = request.form.get("genre5")
    genre6_name = request.form.get("genre6")
    genre7_name = request.form.get("genre7")
    genre8_name = request.form.get("genre8")
    genre9_name = request.form.get("genre9")
    genre10_name = request.form.get("genre10")
    genre11_name = request.form.get("genre11")
    genre12_name = request.form.get("genre12")
    genre13_name = "FREE SQUARE"
    genre14_name = request.form.get("genre13")
    genre15_name = request.form.get("genre14")
    genre16_name = request.form.get("genre15")
    genre17_name = request.form.get("genre16")
    genre18_name = request.form.get("genre17")
    genre19_name = request.form.get("genre18")
    genre20_name = request.form.get("genre19")
    genre21_name = request.form.get("genre20")
    genre22_name = request.form.get("genre21")
    genre23_name = request.form.get("genre22")
    genre24_name = request.form.get("genre23")
    genre25_name = request.form.get("genre24")

    genre1 = Genre(name=genre1_name)
    genre2 = Genre(name=genre2_name)
    genre3 = Genre(name=genre3_name)
    genre4 = Genre(name=genre4_name)
    genre5 = Genre(name=genre5_name)
    genre6 = Genre(name=genre6_name)
    genre7 = Genre(name=genre7_name)
    genre8 = Genre(name=genre8_name)
    genre9 = Genre(name=genre9_name)
    genre10 = Genre(name=genre10_name)
    genre11 = Genre(name=genre11_name)
    genre12 = Genre(name=genre12_name)
    genre13 = Genre(name=genre13_name)
    genre14 = Genre(name=genre14_name)
    genre15 = Genre(name=genre15_name)
    genre16 = Genre(name=genre16_name)
    genre17 = Genre(name=genre17_name)
    genre18 = Genre(name=genre18_name)
    genre19 = Genre(name=genre19_name)
    genre20 = Genre(name=genre20_name)
    genre21 = Genre(name=genre21_name)
    genre22 = Genre(name=genre22_name)
    genre23 = Genre(name=genre23_name)
    genre24 = Genre(name=genre24_name)
    genre25 = Genre(name=genre25_name)

    # Create squares
    square1 = Square(x_coord=1, y_coord=1)
    square2 = Square(x_coord=1, y_coord=2)
    square3 = Square(x_coord=1, y_coord=3)
    square4 = Square(x_coord=1, y_coord=4)
    square5 = Square(x_coord=1, y_coord=5)
    square6 = Square(x_coord=2, y_coord=1)
    square7 = Square(x_coord=2, y_coord=2)
    square8 = Square(x_coord=2, y_coord=3)
    square9 = Square(x_coord=2, y_coord=4)
    square10 = Square(x_coord=2, y_coord=5)
    square11 = Square(x_coord=3, y_coord=1)
    square12 = Square(x_coord=3, y_coord=2)
    square13 = Square(x_coord=3, y_coord=3)
    square14 = Square(x_coord=3, y_coord=4)
    square15 = Square(x_coord=3, y_coord=5)
    square16 = Square(x_coord=4, y_coord=1)
    square17 = Square(x_coord=4, y_coord=2)
    square18 = Square(x_coord=4, y_coord=3)
    square19 = Square(x_coord=4, y_coord=4)
    square20 = Square(x_coord=4, y_coord=5)
    square21 = Square(x_coord=5, y_coord=1)
    square22 = Square(x_coord=5, y_coord=2)
    square23 = Square(x_coord=5, y_coord=3)
    square24 = Square(x_coord=5, y_coord=4)
    square25 = Square(x_coord=5, y_coord=5)
    
    #Append squares to board and assign genres
    new_board.squares.append(square1)
    square1.genre = genre1
    new_board.squares.append(square2)
    square2.genre = genre2
    new_board.squares.append(square3)
    square3.genre = genre3
    new_board.squares.append(square3)
    square3.genre = genre3
    new_board.squares.append(square4)
    square4.genre = genre4
    new_board.squares.append(square5)
    square5.genre = genre5
    new_board.squares.append(square5)
    square5.genre = genre5
    new_board.squares.append(square6)
    square6.genre = genre6
    new_board.squares.append(square7)
    square7.genre = genre7
    new_board.squares.append(square8)
    square8.genre = genre8
    new_board.squares.append(square9)
    square9.genre = genre9
    new_board.squares.append(square10)
    square10.genre = genre10
    new_board.squares.append(square11)
    square11.genre = genre11
    new_board.squares.append(square12)
    square12.genre = genre12
    new_board.squares.append(square13)
    square13.genre = genre13
    new_board.squares.append(square14)
    square14.genre = genre14
    new_board.squares.append(square15)
    square15.genre = genre15
    new_board.squares.append(square16)
    square16.genre = genre16
    new_board.squares.append(square17)
    square17.genre = genre17
    new_board.squares.append(square18)
    square18.genre = genre18
    new_board.squares.append(square19)
    square19.genre = genre19
    new_board.squares.append(square20)
    square20.genre = genre20
    new_board.squares.append(square21)
    square21.genre = genre21
    new_board.squares.append(square22)
    square22.genre = genre22
    new_board.squares.append(square23)
    square23.genre = genre23
    new_board.squares.append(square24)
    square24.genre = genre24
    new_board.squares.append(square25)
    square25.genre = genre25
    
    db.session.add(new_board)
    db.session.commit()

    # get new board ID from DB
    board_id = new_board.board_id

    return redirect('/board/' + str(board_id))


@app.route('/board/<board_id>')
def display_board(board_id):
    """Displays bingo board using information from database"""

    genres = db.session.query(Square).filter_by(board_id=board_id).all()

    genre_ids = []

    for genre in genres:
        genre_id = genre.genre_id
        genre_ids.append(genre_id)

    genre_names = []

    for genre_id in genre_ids:
        genre_object = db.session.query(Genre).filter_by(genre_id=genre_id).one()
        genre_names.append(genre_object.name)

    row1 = genre_names[:5]
    row2 = genre_names[5:10]
    row3 = genre_names[10:15]
    row4 = genre_names[15:20]
    row5 = genre_names[20:]

    rows = [row1, row2, row3, row4, row5]


    return render_template("board.html",
                            genre_names=genre_names,
                            rows=rows)


if __name__ == "__main__":

    app.debug = True
    app.jinja_env.auto_reload = app.debug  # make sure templates, etc. are not cached in debug mode

    connect_to_db(app)

    # Use the DebugToolbar
    DebugToolbarExtension(app)


    
    app.run(port=5000, host='0.0.0.0')