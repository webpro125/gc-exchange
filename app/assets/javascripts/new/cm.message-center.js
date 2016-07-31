(function ($) {
    $(function () {
        var messageCenter = $('.message-center');
        var messageCenterContent = $('.message-center-content');
        var messageCenterHeader = $('.message-center-header');

        var messagePreviews = $('.message-entity-preview');
        var messageThreads = $('.message-thread-container');

        if (!messageCenter.length) return;

        var messages = {};

        // collect message previews and associated ids
        $.each(messagePreviews, function (key, item) {
            var elem = $(item);
            var data = elem.data();

            messages[data.messageTargetId] = messages[data.messageTargetId] || {};
            messages[data.messageTargetId].preview = elem;
        });

        // collect message entities and associated ids
        $.each(messageThreads, function (key, item) {
            var elem = $(item);
            var data = elem.data();

            messages[data.messageId] = messages[data.messageId] || {};
            messages[data.messageId].thread = elem;
        });

        // attach handlers to all messages
        $.each(messages, function (key, item) {
            item.preview.on('click', function () {
                messagePreviews.removeClass('is-active');
                messageThreads.removeClass('is-active');

                item.preview.addClass('is-active');
                item.thread.addClass('is-active');

                messageCenterContent.addClass('message-selected');
                messageCenterHeader.addClass('message-selected');
            });
        });

        // attach handlers to "go back"
        messageCenterHeader.find('.go-back').on('click', function (event) {
            event.preventDefault();

            messagePreviews.removeClass('is-active');
            messageThreads.removeClass('is-active');

            messageCenterContent.removeClass('message-selected');
            messageCenterHeader.removeClass('message-selected');
        });
    });
})(jQuery);
