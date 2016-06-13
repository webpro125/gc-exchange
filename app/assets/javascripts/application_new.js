// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.foundation
//= require foundation
//= require jquery-ui/core
//= require jquery-ui/widget
//= require jquery-ui/mouse
//= require jquery-ui/position
//= require jquery.maxlength
//= require cocoon
//= require confirm-with-reveal.min
//= require select2
//= require foundation-datetimepicker
//= require moment
//= require shared/date-range
//= require widgets
//= require entities
//= require new/bootstrap.min
//= require new/lodash.min
//= require new/cm.accordian
//= require new/cm.input
//= require new/cm.popover
//= require new/cm.toggle
//= require new/cm.workflow
//= require new/main
//= require new/common

$(function() {
    $('.action-close').click(function() {
        $(this).closest('div.ui-notification').remove();
    });

    $("input.work_area_code, input.work_prefix, input.work_line, input.cell_area_code, input.cell_prefix, input.cell_line").keyup(function () {
        next_obj = $(this).closest('div.input-styler').next().next('div.input-styler');
        if (this.value.length == this.maxLength && next_obj.length) {
            next_obj.find("input").focus();
        }
    });
});