from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class User(db.Model):
    """User of Book Bingo"""

    __tablename__ = "users"

    user_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    email = db.Column(db.String(64))
    password = db.Column(db.String(64))
    first_name = db.Column(db.String(30))
    last_name = db.Column(db.String(30))


    boards = db.relationship("Board", secondary="boardusers", backref="users")

    def __repr__(self):
        """Provide helpful representation when printed"""

        return "<User user_id=%s email=%s>" % (self.user_id, self.email)


class BoardUser(db.Model):
    """Association table between User and Board"""

    __tablename__ = "boardusers"

    bu_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    user_id = db.Column(db.Integer,
                        db.ForeignKey('users.user_id'),
                        nullable=False)
    board_id = db.Column(db.Integer,
                        db.ForeignKey('boards.board_id'),
                        nullable=False)

    def __repr__(self):
        """Provide helpful representation when printed"""

        return "<BoardUser bu_id=%s user_id=%s board_id=%s>" % (self.bu_id, 
                                                    self.user_id, self.board_id)


class Board(db.Model):
    """Boards in Book Bingo"""

    __tablename__ = "boards"

    board_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    board_name = db.Column(db.String(64))

    def __repr__(self):
        """Provide helpful representation when printed"""

        return "<Board board_id=%s board_name=%s>" % (self.board_id, self.board_name)

    def get_squares(self, user_id):
        """Run SQLAlchemy query to get board information"""
        
        query_fields = db.session.query(Square.square_id,
                                     Square.genre_id,
                                     Book.title,
                                     Book.author,
                                     SquareUser.user_id,
                                     Genre.name)

        query_joins = query_fields.join(SquareUser, isouter=True).join(Book, isouter=True).join(Genre, isouter=True)
        query_filters = query_joins.filter(Square.board_id==self.board_id, db.or_(SquareUser.user_id == user_id, SquareUser.user_id.is_(None)))
        query_order = query_filters.order_by(Square.square_id)

        query_results = query_order.all()

        return query_results


class Genre(db.Model):
    """Genres represented on the bingo board"""

    __tablename__ = "genres"

    genre_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    name = db.Column(db.String(64))

    def __repr__(self):
        """Provide helpful representation when printed"""

        return "<Genre genre_id=%s name=%s>" % (self.genre_id, self.name)

class Square(db.Model):
    """Squares on the bingo board"""

    __tablename__ = "squares"

    square_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    board_id = db.Column(db.Integer,
                        db.ForeignKey('boards.board_id'),
                        nullable=False)
    genre_id = db.Column(db.Integer,
                        db.ForeignKey('genres.genre_id'),
                        nullable=False)
    x_coord = db.Column(db.Integer)
    y_coord = db.Column(db.Integer)

    
    # Set up relationships with boards and genres 
    board = db.relationship("Board", 
                            backref=db.backref("squares", order_by=board_id))

    genre = db.relationship("Genre", 
                            backref=db.backref("squares", order_by=genre_id))

    def __repr__(self):
        """Provide helpful representation when printed"""

        return "<Square square_id=%s board_id=%s genre_id=%s>" % (self.square_id, 
                                                    self.board_id, self.genre_id)

class SquareUser(db.Model):
    """Association table between Square, User, and Book"""

    __tablename__ = "squareusers"

    squ_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    square_id = db.Column(db.Integer,
                        db.ForeignKey('squares.square_id'),
                        nullable=False)
    user_id = db.Column(db.Integer,
                        db.ForeignKey('users.user_id'),
                        nullable=False)
    book_id = db.Column(db.Integer,
                        db.ForeignKey('books.book_id'),
                        nullable=False)


    user = db.relationship("User", 
                            backref=db.backref("squareusers", order_by=user_id))

    book = db.relationship("Book", 
                            backref=db.backref("squareusers", order_by=book_id))

    square = db.relationship("Square", 
                            backref=db.backref("squareusers", order_by=square_id))

    def __repr__(self):
        """Provide helpful representation when printed"""

        return "<SquareUser squ_id=%s square_id=%s user_id=%s book_id=%s>" % (self.squ_id,
                                        self.square_id, self.user_id, self.book_id)

class Book(db.Model):
    """Books read in Book Bingo"""

    __tablename__ = "books"

    book_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    title = db.Column(db.String(64))
    author = db.Column(db.String(64))

    genres = db.relationship("Genre", secondary="bookgenres", backref="books")

    def __repr__(self):
        """Provide helpful representation when printed"""

        return "<Book book_id=%s title=%s author=%s>" % (self.book_id, 
                                                    self.title, self.author)


class BookGenre(db.Model):
    """Association table between Book and Genre"""

    __tablename__ = "bookgenres"

    bg_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    book_id = db.Column(db.Integer,
                        db.ForeignKey('books.book_id'),
                        nullable=False)
    genre_id = db.Column(db.Integer,
                        db.ForeignKey('genres.genre_id'),
                        nullable=False)

    def __repr__(self):
        """Provide helpful representation when printed"""

        return "<BookGenre bg_id=%s book_id=%s genre_id=%s>" % (self.bg_id, 
                                                    self.book_id, self.genre_id)   


###############################################################################

# Helper functions

def connect_to_db(app):
    """Connect the database to the Flask app."""

    # Configure to use our PstgreSQL database
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql:///bookbingo'
    db.app = app
    db.init_app(app) 

def example_data():
    """Create example data to test the database"""

    u1 = User(email='fake@email.com', password='password', first_name='Al', last_name='Books')
    u2 = User(email='anotherfake@email.com', password='password2', first_name='Ballooincorn', 
              last_name='Jones')

    board1 = Board(board_name="My Board")
    board2 = Board(board_name="Reading")
    #board3 = Board(board_name="Populated Example")

    board1.users.append(u1)
    board2.users.append(u2)
    #board3.users.append(u1)

    book1 = Book(title="This Book", author="Jane Austen")
    book2 = Book(title="Another Book", author="Terry Pratchett")

    genre1 = Genre(name="Romance")
    genre2 = Genre(name="Fantasy")

    book1.genres.append(genre1)
    book2.genres.append(genre2)

    square1 = Square(x_coord=1, y_coord=1)
    square2 = Square(x_coord=1, y_coord=2)
    #square1 = Square(x_coord=1, y_coord=1)
    #board3.squares.append(square1)
    #etc

    board1.squares.append(square1)
    board2.squares.append(square2)

    square1.genre = genre1
    square2.genre = genre2

    su1 = SquareUser()
    su2 = SquareUser()

    su1.user = u1
    su1.square = square1
    su1.book = book1

    su2.user = u2
    su2.square = square2
    su2.book = book2

    db.session.add_all([su1, su2])
    db.session.commit()


if __name__ == "__main__":
    # As a convenience, if we run this module interactively, it will leave
    # you in a state of being able to work with the database directly.

    from server import app
    connect_to_db(app)
    print "Connected to DB."
