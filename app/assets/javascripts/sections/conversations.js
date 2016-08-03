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
    $('li.message-entity-preview').on('click', function() {
        var this_obj = $(this);
        var conversation_id = this_obj.attr('data-message-target-id');
        if (!this_obj.hasClass('is-read')) {
            $.ajax({
                url: '/conversations/' + conversation_id + '/read_conversation',
                method: 'POST',
                dataType: 'json',
                success: function (data) {
                    this_obj.addClass('is-read');
                    this_obj.find('div.message-markers').remove();
                }
            })
        }
    });
  });
})();
