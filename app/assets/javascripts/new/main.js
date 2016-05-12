(function ($) {
    $(function () {
        var modals = $('[data-type~="cm-modal"]');

        if (!modals.length) return;

        var modal = $('.ui-modal');
        var close = modal.find('.modal-close');

        modals.on('click', function () {
            modal.show();
        });

        modal.on('click', function (event) {
            if (!$(event.target).closest('.modal-box').length) {
                modal.hide();
            }
        });

        close.on('click', function () {
            modal.hide();
        });
    });
})(jQuery);
