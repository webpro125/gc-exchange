(function ($) {
    $(function () {
        var options = {
            flash: {
                delay: 4000
            }
        };

        var modals = $('[data-type~="cm-modal"]');

        if (!modals.length) return;

        _.each(modals, function (item) {
            var modal = $(item);
            var data = modal.data();

            if (!data.modalTarget) {
                console.log('cm.modal:', 'data-modal-target must be defined', modal);
            }

            var target = $('[data-name~="' + data.modalTarget + '"]');

            if (!target.length) {
                console.log('cm.modal:', 'data-name="' + data.modalTarget + '" must be defined', modal)
            }

            var close = target.find('[data-modal-close]');
            var timer;

            _.merge(data, target.data());

            modal.on('click', function (event) {
                event.preventDefault();
                target.show();

                if (typeof data.modalFlash !== 'undefined') {
                    timer = setTimeout(function () {
                        target.hide();
                    }, options.flash.delay);
                }
            });

            target.on('click', function (event) {
                if (!$(event.target).closest('[data-modal-box]').length) {
                    clearTimeout(timer);
                    target.hide();
                }
            });

            close.on('click', function (event) {
                event.preventDefault();
                clearTimeout(timer);
                target.hide();
            });
        });
    });
})(jQuery);
