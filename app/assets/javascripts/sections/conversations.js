(function() {
  'use strict';

  $(document).ready(function() {
    var form = $('.respond-to-message-form');
    var interestedBtn = $('.respond-to-message');

    var replyBtn = $('#reply-btn');
    var replyForm = $('#reply');

    interestedBtn.on('click', function() {
      form.show().transition({
        opacity: 100
      });
    });

    replyBtn.on('click', function(){
      replyForm.show().transition({
        opacity: 100
      });
    });
  });
})();
