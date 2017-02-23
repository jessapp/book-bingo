import unittest

from server import app

import board

from goodreads import (url_to_dict, create_url, get_title, get_author, get_image_url,
                        get_goodreads_id, get_description)

from model import db, example_data, connect_to_db

from flask import json


######################################################################
# Tests that don't require the database or an active session
######################################################################


class BookBingoBasicTests(unittest.TestCase):
    """Tests for Book Bingo pages that don't require a database."""

    def setUp(self):
        self.client = app.test_client()
        app.config['TESTING'] = True

    def test_homepage(self):
        result = self.client.get("/")
        self.assertIn("Book Bingo", result.data)

    def test_login_page(self):
        result = self.client.get("/login")
        self.assertIn("Log In", result.data)

    def test_register_page(self):
        result = self.client.get("/register")
        self.assertIn("First Name", result.data)

    def test_about(self):
        result = self.client.get('/about')
        self.assertIn("How do I play", result.data)



######################################################################
# Tests that require an active session, but no database access
######################################################################


class BookBingoSessionTests(unittest.TestCase):
    """Tests that require the session to be active but do not interact
    with the database."""

    def setUp(self):
        self.client = app.test_client()
        app.config['TESTING'] = True

        add_test_user_to_session(self.client)

    def test_logout(self):
        add_test_user_to_session(self.client)

        result=self.client.get("/logout", follow_redirects=True)
        self.assertIn("Log Out", result.data)



######################################################################
# Tests that require database access but not an active session. These
# should not be able to change the database.
######################################################################

class BookBingoQueriesTestsNoSessionTests(unittest.TestCase):
    """Tests that query the database but don't require a session."""

    def setUp(self):
        """Necessary before every test. Creates client, configures the app, 
        connects to test database, creates the tables, and seeds the test database."""

        self.client = app.test_client()
        app.config['TESTING'] = True

        connect_to_db(app, "postgresql:///testdb")

        db.create_all()
        example_data()

    def tearDown(self):
        """Do at the end of every test"""

        db.session.close()
        db.drop_all()

######################################################################
# Tests that require database access and an active session, but don't
# alter the state of the database.
######################################################################

class BookBingoQueriesAndSessionTests(unittest.TestCase):
    """Tests that query the database and require a session, but don't alter the
    database."""

    def setUp(self):
        """Necessary before every test. Creates client, configures the app, 
        connects to test database, creates the tables, and seeds the test database."""

        self.client = app.test_client()
        app.config['TESTING'] = True

        connect_to_db(app, "postgresql:///testdb")

        db.create_all()
        example_data()

        add_test_user_to_session(self.client)

    def tearDown(self):
        """Do at the end of every test"""

        db.session.close()
        db.drop_all()

    def test_login(self):
        result = self.client.post("/login",
                                  data={"email": "fake@email.com",
                                        "password": "secretpassword"},
                                        follow_redirects=True)

        self.assertIn("Welcome, Jess", result.data)

    def test_show_boards(self):
        """Test that boards are displaying on user homepage"""

        result = self.client.get("/users/1")
        self.assertIn("My Board", result.data)
        self.assertNotIn("Log In", result.data)

    def test_new_board(self):
        """Test ability to get to new board page"""

        result = self.client.get("/create-board")
        self.assertIn("New Board", result.data)
        self.assertNotIn("Welcome", result.data)

    def test_board_display(self):
        """Test squares displaying on board"""

        result = self.client.get("/board/1")
        self.assertIn("Romance", result.data)
        self.assertNotIn("Welcome", result.data)



######################################################################
# Tests that require database access, need an active session, and
# can actually change the database.
######################################################################

class BookBingoDBTests(unittest.TestCase):
    """Tests that alter the test database."""

    def setUp(self):
        """Necessary before every test. Creates client, configures the app, 
        connects to test database, creates the tables, and seeds the test database."""

        self.client = app.test_client()
        app.config['TESTING'] = True

        connect_to_db(app, "postgresql:///testdb")

        db.create_all()
        example_data()

        add_test_user_to_session(self.client)

    def tearDown(self):
        """Do at the end of every test"""

        db.session.close()
        db.drop_all()

    def test_registration(self):
        """Test registration process"""

        result = self.client.post("/register",
                                  data={'f-name': "Malcolm",
                                        'l-name': "Reynolds",
                                        'email': "browncoat@serenity.com",
                                        'password': "abc123"})

        self.assertEqual(result.status_code, 302)

    def test_create_board(self):
        """Test new board creation process"""

        data = {'board-name': 'New Board',
                'genre1': 'Fiction',
                'genre2': 'Romance',
                'genre3': 'Horror',
                'genre4': 'Biography',
                'genre5': 'Non-Fiction',
                'genre6': 'Magical Realism',
                'genre7': 'Fantasy',
                'genre8': 'Science Fiction',
                'genre9': 'Dystopia',
                'genre10': 'Poetry',
                'genre11': 'Female Author',
                'genre12': 'Banned Book',
                'genre13': 'Memoir',
                'genre14': 'Literary Classic',
                'genre15': 'More Than 500 Pages',
                'genre16': 'True Crime',
                'genre17': 'Historical Fiction',
                'genre18': 'Graphic Novel',
                'genre19': 'YA Fiction',
                'genre20': 'Written The Year You Were Born',
                'genre21': 'Color In the Title',
                'genre22': 'National Book Award Winner',
                'genre23': 'Book Involving Music',
                'genre24': 'Recommended By A Friend'
                }

        result = self.client.post("/create-board",
                                  data=data)

        self.assertEqual(result.status_code, 302)


######################################################################
# API Call tests
######################################################################

class GoodreadsTests(unittest.TestCase):
    """Tests for GoodReads API calls"""

    xmldict = url_to_dict("https://www.goodreads.com/search/index.xml?key=57iWBPEbWuijEvz7vjVKA&q=Ender%27s+Game")
    enders_game_id = get_goodreads_id(xmldict)

    def test_url(self):
        self.assertEqual(create_url("Ender's Game"), 
            'https://www.goodreads.com/search/index.xml?key=57iWBPEbWuijEvz7vjVKA&q=Ender%27s+Game')


    def test_title(self):
        self.assertEqual(get_title(self.xmldict), "Ender's Game (Ender's Saga, #1)")


    def test_author(self):
        self.assertEqual(get_author(self.xmldict), "Orson Scott Card")


    def test_image_url(self):
        self.assertEqual(get_image_url(self.xmldict), "https://images.gr-assets.com/books/1408303130m/375802.jpg")

    def test_get_id(self):
        self.assertEqual(get_goodreads_id(self.xmldict), "375802")


######################################################################
# Helper functions to run the tests
######################################################################


def add_test_user_to_session(client):
    with client.session_transaction() as session:
        session['user_id'] = 1


if __name__ == "__main__":
    unittest.main()