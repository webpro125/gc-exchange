(function() {
  'use strict';

  function toggleClearance(toggle) {
    if(toggle.toLowerCase() === 'true') {
      $('.clearance-hidden').show();
    }else{
      $('.clearance-hidden').hide();
    }
  }

  function toggleMilitary(toggle) {
    if(toggle.toLowerCase() === 'true') {
      $('.military-hidden').show();
    }else{
      $('.military-hidden').hide();
    }
  }

  $(document).ready(function(){
    var clearance = $('#consultant_military_attributes_clearance_active');
    var military = $('#consultant_military_attributes_military');

    clearance.on('change', function(){
      toggleClearance($(this).val());
    });

    military.on('change', function(){
      toggleMilitary($(this).val());
    });

    if(clearance.length > 0 && military.length > 0) {
      toggleClearance(clearance.val());
      toggleMilitary(military.val());
    }

    var rate = $('#consultant_rate');

    rate.on('blur', function() {
      var _this = $(this);
      var val = _this.val();

      _this.val(parseFloat(val).toFixed(2));
    });
  });
})();
