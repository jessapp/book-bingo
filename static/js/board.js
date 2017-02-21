"use strict";
    
// Ajax call success function
function showTitle(result){
    console.log(result);


    $("#books-read-" + result.square_id).html("You read " + result.title + " by " + result.author);
    $("#square-" + result.square_id).addClass("read");
    $("#data-fields-" + result.square_id).hide();

    var x_coord = result.x_coord;
    var y_coord = result.y_coord;
    console.log(y_coord)
    console.log(x_coord)

    getBingo(x_coord, y_coord);

}

// Ajax call - to do: refactor for optimized runtime
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


// Create alert when a user gets 5 boxes in a row
function getBingo(x_coord, y_coord) {

    console.log(x_coord);
    console.log(y_coord);

    if ($('.read[data-ycoord='+y_coord+']').length == 5 || $('.read[data-xcoord='+x_coord+']').length == 5) {
        alert("Bingo!");
    }
};
