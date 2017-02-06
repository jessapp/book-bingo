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


    first_name = db.session.query(User).filter_by(user_id=user_id).one().first_name  
    
    # Link to new board
    # Link to user's current boards through db queries


    return render_template("user_details.html",
                    first_name=first_name)


if __name__ == "__main__":

    app.debug = True
    app.jinja_env.auto_reload = app.debug  # make sure templates, etc. are not cached in debug mode

    connect_to_db(app)

    # Use the DebugToolbar
    DebugToolbarExtension(app)


    
    app.run(port=5000, host='0.0.0.0')