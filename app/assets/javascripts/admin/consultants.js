// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es.js
//= require wice_grid

$(function() {
    $('#upload-resume').change(function() {
        $(this).closest('form').submit();
    });
});
$(document).on("click",".consultant-positions",function() {
    remaining_positions = $(this).parents("td").find(".remaining-positions")
    if(remaining_positions.is(":visible")) {
        $(this).text("More");
        remaining_positions.hide()
    }
    else{
        $(this).text("Less");
        remaining_positions.show()
    }
    return false;
});