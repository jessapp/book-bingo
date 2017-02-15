def create_rows(lst):
    """Splits list of squares into list of rows - to be used with Jinja"""

    row1 = lst[:5]
    row2 = lst[5:10]
    row3 = lst[10:15]
    row4 = lst[15:20]
    row5 = lst[20:]

    # Creates lists of rows 
    board_rows = [row1, row2, row3, row4, row5]

    return board_rows