(function() {
  'use strict';

  function toggleClearance(toggle) {
    if(toggle) {
      $('#security').show();
    }else{
      $('#security').hide();
    }
  }

  $(document).ready(function(){
    $('#consultant_military_attributes_clearance_active').on('click', function(){
      toggleClearance($(this).is(':checked'));
    });

    toggleClearance($(this).is(':checked'));
  });
})();
