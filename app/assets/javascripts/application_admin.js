// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require plugins/metisMenu/jquery.metisMenu
//= require plugins/slimscroll/jquery.slimscroll.min
//= require inspinia
//= require plugins/pace/pace.min
//= require jquery-ui/core
//= require jquery-ui/widget
//= require jquery-ui/mouse
//= require jquery-ui/position
//= require moment
//= require date-range
//= require select2
//= require widgets

$(document).ready(function() {
    $('select, .select2').select2Dropdown();
});