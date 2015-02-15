(function() {
  'use strict';

  $(document).ready(function() {
    var form = $('#pending-contact-request');
    var interestedBtn = $('#interested');

    interestedBtn.on('click', function() {
      form.show()
          .transition({
            opacity: 100
          });
    });
  });
})();
