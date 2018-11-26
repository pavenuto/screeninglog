$(function(){

    var $pagination = $(".pagination");

    if ($pagination.length) {

        $(window).keydown(function(e){

            // Right Arrow
            if ( e.which === 26 ) {
                $(".next_page").click();

            // Left Arrow
            } else if ( e.which === 27 ) {
                $(".previous_page").click();

                console.log("hahaha");
            }

        });

    }

    $("#screenings").tablesorter();


});