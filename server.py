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

    session['username'] = email
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

    session['username'] = email
    flash("Logged in!")

    return redirect("/")


@app.route('/logout', methods=["GET"])
def logout():
    """Render logout form"""

    return render_template("logout.html")


@app.route('/logout', methods=["POST"])
def logout_complete():
    """Implement user logout"""

    del session["username"]
    flash("Logged out!")

    return redirect("/")


@app.route('/users/<user_id>')
def display_user(user_id):
    """User homepage"""

    # board_list = []

    # for board in user_boards:
    #     board_id = board.board_id
    #     board_list.append(board_id)

    # board_names = []

    # for board_id in board_list:
    #     board_name = board.board_name
    #     board_names.append(board_name)


    first_name = db.session.query(User).filter_by(user_id=user_id).one().first_name

    # Finds user's boards 
    user_boards = db.session.query(User).filter_by(user_id=3).one().boards 

    boards = []

    for board in user_boards:
        board_name = board.board_name
        board_id = board.board_id
        boards.append(board_name)
    
    # Link to new board

    return render_template("user_details.html",
                    first_name=first_name,
                    board_id=board_id,
                    boards=boards,
                    board_name=board_name)

@app.route('/board/<board_id>')
def display_board(board_id):
    """Displays bingo board"""

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