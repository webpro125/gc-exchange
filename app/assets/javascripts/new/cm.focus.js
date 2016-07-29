(function ($) {
    $(function () {
        var focus = $('[data-type~="cm-focus"]');

        _.each(focus, function (value) {
            var element = $(value);
            var data = element.data();

            if (!data.focus) {
                console.log('cm.toggle[error]', 'data-focus must be defined', element);
                return;
            }

            var target = $('[data-focus-target~="' + data.focus + '"]');

            if (!target.length) {
                console.log('cm.toggle[error]', 'could not find target data-type="' + data.target + '"', element);
            }

            element.on('focus', function () {
                target.addClass('focus');
            });

            element.on('blur', function () {
                if (element.val() == '') {
                    target.removeClass('focus');
                }
            });
        });
    });
})(jQuery);
