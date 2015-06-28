$(document).ready(function() {
  $('#consultants').dataTable({
    bJQueryUI:  true,
    processing: true,
    serverSide: true,
    scrollX:    true,
    ajax:       $('#consultants ').data('source')
  });
});
