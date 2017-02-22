"""Book Bingo"""

from jinja2 import StrictUndefined

from flask import (Flask, jsonify, render_template, redirect, request, flash,
                   session)
from flask_debugtoolbar import DebugToolbarExtension

from model import (User, BoardUser, Board, Genre, Square, SquareUser, Book, 
                   BookGenre, connect_to_db, db)

from board import (user_login, register_new_user, get_user_boards, create_new_board,
                    add_user_to_board,create_genres, create_squares, 
                    update_database, connect_to_goodreads)

from sqlalchemy.orm.exc import NoResultFound

import json



app = Flask(__name__)

app.secret_key = "ks3sn4kynsna87d6f5"

app.jinja_env.undefined = StrictUndefined



@app.route('/')
def index():
    """Homepage"""

    return render_template("homepage.html")

@app.route('/about')
def about():
    """About page"""

    return render_template("about.html")


@app.route('/login', methods=["GET"])
def login_form():
    """Render login form"""

    return render_template("login.html")


@app.route('/login', methods=["POST"])
def login_process():
    """Execute login process"""

    # email = request.form.get("email")

    # password = request.form.get("password")

    # try:
    #     db.session.query(User).filter_by(email=email).one().email
    #     password == db.session.query(User).filter_by(email=email).one().password
    # except NoResultFound:
    #     flash("Login information inccorect")
    #     return redirect("/login")

    # user_id = db.session.query(User).filter_by(email=email).one().user_id


    # session['user_id'] = user_id
    # flash("Logged in!")

    user_id = user_login()

    if 'board_id' in session:
        board_id = session['board_id']
        board = Board.query.get(board_id)
        user = User.query.get(user_id)
        board.users.append(user)
        db.session.commit()
        del session['board_id']
        return redirect("/board/" + str(board_id))
    else:
        return redirect("/users/" + str(user_id))

@app.route('/register', methods=["GET"])
def register_form():
    """Render registration form"""

    return render_template("register.html")


@app.route('/register', methods=["POST"])
def register_process():
    """Add new user to database"""

    user_id = register_new_user()

    if 'board_id' in session:
        board_id = session['board_id']
        board = Board.query.get(board_id)
        user = User.query.get(user_id)
        board.users.append(user)
        db.session.commit()
        del session['board_id']
        return redirect("/board/" + str(board_id))
    else:
        return redirect("/users/" + str(user_id))


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

    boards = get_user_boards(user_id)

    return render_template("user_details.html",
                    first_name=first_name,
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

    # Create new board
    new_board = create_new_board()

    # Add user and genres
    genres_text = add_user_to_board(new_board)


    # Instantiate genre and square objects
    genre_objects = create_genres(genres_text)
    squares = create_squares(new_board, genre_objects)

    
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
    board_rows = this_board.get_squares(user_id)


    return render_template("board.html",
                            board_rows=board_rows,
                            board_id=board_id)



@app.route('/update-board.json', methods=["POST"])
def process_submission():
    """Processes Ajax call information to update board"""

    
    # Update the database with information from the board
    new_Sqaureuser = update_database()


    # API Calls
    book_data = connect_to_goodreads()


    return jsonify(book_data)


@app.route('/board/<board_id>/invite', methods=["GET"])
def invite_friends(board_id):
    """Landing page to invite new users to board"""

    session['board_id'] = board_id

    return render_template("board_invite.html")



if __name__ == "__main__":

    app.debug = True
    app.jinja_env.auto_reload = app.debug  # make sure templates, etc. are not cached in debug mode

    connect_to_db(app)

    # Use the DebugToolbar
    DebugToolbarExtension(app)


    
    app.run(port=5000, host='0.0.0.0')