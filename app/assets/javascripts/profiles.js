(function() {
  'use strict';

  function toggleClearance(toggle) {
    if(toggle.toLowerCase() === 'true') {
      $('#security').show();
    }else{
      $('#security').hide();
    }
  }

  function toggleMilitary(toggle) {
    if(toggle.toLowerCase() === 'true') {
      $('#military').show();
    }else{
      $('#military').hide();
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
  });
})();
