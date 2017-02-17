from model import Genre, Square

def create_genres(genre_lst):
    """Instantiates genre objects"""

    genre_objects = []

    for genre_text in genre_lst:
        genre_objects.append(Genre(name=genre_text))

    return genre_objects

def create_squares():
    """Creates squares for the board"""

    squares = []

    coordinate_list = [(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (2, 1), (2, 2), 
    (2, 3), (2, 4), (2, 5),(3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (4, 1), 
    (4, 2), (4, 3), (4, 4), (4, 5), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5)]
    
    for coordinate in coordinate_list:
        squares.append(Square(x_coord=coordinate[0], y_coord=coordinate[1]))

    return squares



def create_rows(lst):
    """Splits list of squares into list of rows - to be used with Jinja"""
    row1 = lst[0]
    row2 = lst[1]
    row3 = lst[2]
    row4 = lst[3]
    row5 = lst[4]

    # Creates lists of rows 
    board_rows = [row1, row2, row3, row4, row5]

    return board_rows