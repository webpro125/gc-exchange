$(document).ready(function() {
  $('#consultants').dataTable({
    bJQueryUI:  true,
    processing: true,
    serverSide: true,
    scrollX:    true,
    ajax:       $('#consultants ').data('source')
  });

});

$(document).on("click",".consultant-positions",function() {
    remaining_positions = $(this).parents("td").find(".remaining-positions")
    if(remaining_positions.is(":visible")) {
      $(this).text("More")
      remaining_positions.hide()
    }
    else{
      $(this).text("Less")
      remaining_positions.show()
    }
    return false;
});
