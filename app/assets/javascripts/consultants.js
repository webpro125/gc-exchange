$(document).ready(function() {
    $('#consultants').dataTable({
        bJQueryUI:  true,
        processing: true,
        serverSide: true,
        ajax:       $('#consultants ').data('source')
    })
} );
