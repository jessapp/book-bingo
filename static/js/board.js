"use strict";
    
// Ajax call success function
function showTitle(result){
    console.log(result);


    $("#books-read-" + result.square_id).html("You read " + result.title + " by " + result.author);
    $("#square-" + result.square_id).addClass("read");
    $("#data-fields-" + result.square_id).hide();

}

// When submit is clicked, target that individual book text input
$(function() {
  $(".submit").on("click", function(event) {
    event.preventDefault();
    var book = $(this).siblings(".book");
    var author = $(this).siblings(".author");

    var formInputs = {
        "book": book.val(),
        "square_id": book.data("square-id"),
        "author": author.val(),
    }

    $.post("/update-board.json",
            formInputs,
            showTitle
        )
  })    
});

// Create alert when a user gets 5 boxes in a row
function getBingo() {

    // If all squares with y_coord = 1 have the class read, alert 
    if ($('*[data-ycoord='1']'.hasClass("read")) {
        alert("Bingo!");
    }
}

$(".submit").on("click", getBingo);
