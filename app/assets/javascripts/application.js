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
//= require date-range
//= require widgets
//= require entities

$(document).foundation({
  orbit: {
    animation: 'fade',
    timer: false,
    pause_on_hover: true,
    slide_number: false,
    navigation_arrows: false,
    bullets: false,
    variable_height: true,
    next_on_click: false
  }
});

$(document).ready(function() {
  $(document).confirmWithReveal();
  $(function(){ $(document).foundation(); });
  $('select, .select2').select2Dropdown();

  $('.form-datepicker').fdatetimepicker({
    format: 'MM dd yyyy',
    minView: 2,
    startView: 4,
    forceParse: true
  });

  $('textarea').maxlength();

  var rate = $('#consultant_rate, #project_proposed_rate');

  rate.on('blur', function() {
    var _this = $(this);
    var val = _this.val();

    _this.val(parseFloat(val).toFixed(2));
  });
});
