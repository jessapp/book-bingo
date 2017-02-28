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


    // Alert for left-right diagonal bingo

    if (x_coord === y_coord) {
        var counter = 0;
        for (var i = 1; i <= 5; i++) {
            if ($('[data-ycoord=' + i + '][data-xcoord=' + i + ']').hasClass('read') === true) {
                counter += 1;
            }
        }
        if (counter === 5) {
            alert("Bingo!");
        }
    };

    // Alert for right-left diagonal bingo

    if (parseInt(x_coord) + parseInt(y_coord) === 6) {
            var new_counter = 0;
            for (var i = 1; i <= 5; i++) {
                if ($('[data-ycoord=' + (6 - i) + '][data-xcoord=' + i + ']').hasClass('read') === true) {
                    new_counter += 1;
                    }
                }

            if (new_counter === 5) {
            alert("Bingo!");
            }
        };
};


// Activate modals
function modal(evt) {
    $('#exampleModalLong').modal('show');
    }

modal();
