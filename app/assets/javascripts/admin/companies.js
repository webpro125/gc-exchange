// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es.js
//= require jquery-ui/autocomplete
//= require autocomplete-rails

$(function() {
    $('.form-datepicker').datepicker({
        todayBtn: "linked",
        keyboardNavigation: false,
        calendarWeeks: true,
        autoclose: true,
        format: "yyyy-mm-dd"
    });
    $('input#company_email').bind('autocompleteselect', function(event, ui) {
        //console.log(ui.item.id)
        $('input#company_first_name').val(ui.item.first_name);
        $('input#company_last_name').val(ui.item.last_name)
    }).on("change paste keyup", function() {
        if ($(this).val() == '') {
            $('input#company_first_name').val('');
            $('input#company_last_name').val('')
        }
    });

    $('input#account_manager_email').bind('autocompleteselect', function(event, ui) {
        //console.log(ui.item.id)
        $('input#account_manager_first_name').val(ui.item.first_name);
        $('input#account_manager_last_name').val(ui.item.last_name)
    }).on("change paste keyup", function() {
        if ($(this).val() == '') {
            $('input#account_manager_first_name').val('');
            $('input#account_manager_last_name').val('')
        }
    });
});