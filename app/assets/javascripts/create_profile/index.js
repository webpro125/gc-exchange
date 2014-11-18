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

    toggleClearance(clearance.val());
    toggleMilitary(military.val());
  });
})();
