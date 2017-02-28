# Book Bingo

Book Bingo is a full-stack web application which makes setting reading goals fun. Upon logging in, users create customizable bingo boards in which each square to corresponds to a book genre. When the user has read a book corresponding to that genre, they enter the title and author, allowing Book Bingo to connect to the Goodreads API and fetch the book's description. User information, books read, and board information are stored in a PostgreSQL database. Once a square has been read, the board gives immediate visual feedback, allowing users to easily keep track which genre categories they've completed. When a user has read five books in a row (vertically, horozontally, or diagnoally), they get bingo! 

Users can set personal reading goals by playing on their own, or play with friends by inviting others to share their board. If a user is sharing their board, they can see descriptions of which books their friends have read for each category. 

---


### Technical Stack

* Python
* Flask
* JavaScript
* PostreSQL
* SQLAlchemy
* AJAX/JSON
* JQuery
* Jinja2
* Bootstrap
* HTML
* CSS
* Goodreads API

(Dependencies are listed in requirements.txt)

---

### Features

* User registration and login (PostgreSQL/SQLAlchemy)
* Flask app renders HTML and handles requests to the database
* Search for book descriptions through the Goodreads API
* AJAX and jQuery provide real-time feedback on the board
* Dynamic share links allow users to invite friends to collaborate on a board
* Modal windows provide details about each genre, including which books other users on the board have read

---
### Author

Jessica Appelbaum is a software engineer living in San Francisco, CA.