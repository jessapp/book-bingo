"use strict";
    
// Ajax call success function
function showTitle(result){
    console.log(result);


    $("#books-read-" + result.square_id).html("You read " + result.title + " by " + result.author);
    $("#square-" + result.square_id).addClass("read");
    $("#data-fields-" + result.square_id).hide();

    var x_coord = result.x_coord;
    var y_coord = result.y_coord;

    getBingo(x_coord, y_coord);

}

// Ajax call
$(function() {
  $(".submit").on("click", function(event) {
    event.preventDefault();
    var book = $(this).siblings(".book");
    var author = $(this).siblings(".author");
    var y_coord = $(this).closest('td').data('ycoord');
    var x_coord = $(this).closest('td').data('xcoord');     


    var formInputs = {
        "book": book.val(),
        "square_id": book.data("square-id"),
        "author": author.val(), 
        "y_coord": y_coord,
        "x_coord": x_coord,
    }

    $.post("/update-board.json",
            formInputs,
            showTitle
        )

  })    
});


function getBingo(x_coord, y_coord) {

    // Create alert when a user gets 5 boxes in a row
    if ($('.read[data-ycoord='+y_coord+']').length == 5 || $('.read[data-xcoord='+x_coord+']').length == 5) {
        alert("Bingo!");
    };

    // Alert left-right for diagonal 

    if (y_coord == 1 &&
        x_coord == 1 &&
        $('[data-ycoord='+y_coord+'][data-xcoord='+x_coord+']').hasClass("read") &&
        $('[data-ycoord=2][data-xcoord=2]').hasClass("read") &&
        $('[data-ycoord=3][data-xcoord=3]').hasClass("read") && 
        $('[data-ycoord=4][data-xcoord=4]').hasClass("read") && 
        $('[data-ycoord=5][data-xcoord=5]').hasClass("read")) {
        alert("Bingo!");
    };

    if (y_coord == 2 &&
        x_coord == 2 &&
        $('[data-ycoord=1][data-xcoord=1]').hasClass("read") &&
        $('[data-ycoord='+y_coord+'][data-xcoord='+x_coord+']').hasClass("read") &&
        $('[data-ycoord=3][data-xcoord=3]').hasClass("read") && 
        $('[data-ycoord=4][data-xcoord=4]').hasClass("read") && 
        $('[data-ycoord=5][data-xcoord=5]').hasClass("read")) {
        alert("Bingo!");
    };

    if (y_coord == 3 &&
        x_coord == 3 &&
        $('[data-ycoord=1][data-xcoord=1]').hasClass("read") &&
        $('[data-ycoord=2][data-xcoord=2]').hasClass("read") &&
        $('[data-ycoord='+y_coord+'][data-xcoord='+x_coord+']').hasClass("read") && 
        $('[data-ycoord=4][data-xcoord=4]').hasClass("read") && 
        $('[data-ycoord=5][data-xcoord=5]').hasClass("read")) {
        alert("Bingo!");
    };

    if (y_coord == 4 &&
        x_coord == 4 &&
        $('[data-ycoord=1][data-xcoord=1]').hasClass("read") &&
        $('[data-ycoord=2][data-xcoord=2]').hasClass("read") &&
        $('[data-ycoord=3][data-xcoord=3]').hasClass("read") && 
        $('[data-ycoord='+y_coord+'][data-xcoord='+x_coord+']').hasClass("read") && 
        $('[data-ycoord=5][data-xcoord=5]').hasClass("read")) {
        alert("Bingo!");
    };

    if (y_coord == 5 &&
        x_coord == 5 &&
        $('[data-ycoord=1][data-xcoord=1]').hasClass("read") &&
        $('[data-ycoord=2][data-xcoord=2]').hasClass("read") &&
        $('[data-ycoord=3][data-xcoord=3]').hasClass("read") && 
        $('[data-ycoord=4][data-xcoord=4]').hasClass("read") && 
        $('[data-ycoord='+y_coord+'][data-xcoord='+x_coord+']').hasClass("read")) {
        alert("Bingo!");
    };



   // Alert right-left for diagonal 

       if (y_coord == 5 &&
        x_coord == 1 &&
        $('[data-ycoord='+y_coord+'][data-xcoord='+x_coord+']').hasClass("read") &&
        $('[data-ycoord=4][data-xcoord=2]').hasClass("read") &&
        $('[data-ycoord=3][data-xcoord=3]').hasClass("read") && 
        $('[data-ycoord=2][data-xcoord=4]').hasClass("read") && 
        $('[data-ycoord=1][data-xcoord=5]').hasClass("read")) {
        alert("Bingo!");
    };

    if (y_coord == 4 &&
        x_coord == 2 &&
        $('[data-ycoord=5][data-xcoord=1]').hasClass("read") &&
        $('[data-ycoord='+y_coord+'][data-xcoord='+x_coord+']').hasClass("read") &&
        $('[data-ycoord=3][data-xcoord=3]').hasClass("read") && 
        $('[data-ycoord=2][data-xcoord=4]').hasClass("read") && 
        $('[data-ycoord=1][data-xcoord=5]').hasClass("read")) {
        alert("Bingo!");
    };

    if (y_coord == 3 &&
        x_coord == 3 &&
        $('[data-ycoord=5][data-xcoord=1]').hasClass("read") &&
        $('[data-ycoord=4][data-xcoord=2]').hasClass("read") &&
        $('[data-ycoord='+y_coord+'][data-xcoord='+x_coord+']').hasClass("read") && 
        $('[data-ycoord=2][data-xcoord=4]').hasClass("read") && 
        $('[data-ycoord=1][data-xcoord=5]').hasClass("read")) {
        alert("Bingo!");
    };

    if (y_coord == 2 &&
        x_coord == 4 &&
        $('[data-ycoord=5][data-xcoord=1]').hasClass("read") &&
        $('[data-ycoord=4][data-xcoord=2]').hasClass("read") &&
        $('[data-ycoord=3][data-xcoord=3]').hasClass("read") && 
        $('[data-ycoord='+y_coord+'][data-xcoord='+x_coord+']').hasClass("read") && 
        $('[data-ycoord=1][data-xcoord=5]').hasClass("read")) {
        alert("Bingo!");
    };

    if (y_coord == 1 &&
        x_coord == 5 &&
        $('[data-ycoord=5][data-xcoord=1]').hasClass("read") &&
        $('[data-ycoord=4][data-xcoord=2]').hasClass("read") &&
        $('[data-ycoord=3][data-xcoord=3]').hasClass("read") && 
        $('[data-ycoord=2][data-xcoord=4]').hasClass("read") && 
        $('[data-ycoord='+y_coord+'][data-xcoord='+x_coord+']').hasClass("read")) {
        alert("Bingo!");
    };

};
