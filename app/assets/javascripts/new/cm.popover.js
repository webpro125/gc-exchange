(function ($) {
    $(function () {
        var popovers = $('[data-type~="cm-popover"]');
        var popoverTemplate = $('.ui-popover');

        $.each(popovers, function (key, value) {
            var element = $(value);
            var data = element.data();
            var placement = data.placement || 'left';

            if (!data.template) {
                console.log('cm.popover[error]', 'data-template must be defined', element);
                return;
            }

            var templateName = 'template-' + data.template;
            var template = element.find('[data-type="' + templateName + '"]');

            if (!template.length) {
                console.log('cm.popover[error]', 'data-type="' + templateName + '" must be defined', element);
                return;
            }

            template.detach().removeAttr('data-type');

            var hasPopover = false;
            var setPopover = true;
            var popover = popoverTemplate.clone().append(template.show());

            element.on('click', function () {
                if (setPopover) {
                    setPopover = false;

                    element.popover({
                        container: 'body',
                        content: '~',
                        placement: placement,
                        template: popover,
                        trigger: 'manual'
                    });
                }

                element.popover('show');
            });

            element.on('shown.bs.popover', function () {
                hasPopover = true;
            });

            element.on('hidden.bs.popover', function () {
                hasPopover = false;
            });

            $(document).on('click', function (event) {
                if (hasPopover) {
                    var target = $(event.target);

                    if (!target.closest('.ui-popover').length) {
                        element.popover('hide');
                    }
                }
            });
        });
    });
})(jQuery);
