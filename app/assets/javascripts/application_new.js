// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.foundation
//= require foundation
//= require jquery-ui/core
//= require jquery-ui/widget
//= require jquery-ui/mouse
//= require jquery-ui/position
//= require jquery.maxlength
//= require cocoon
//= require confirm-with-reveal.min
//= require select2
//= require foundation-datetimepicker
//= require moment
//= require date-range
//= require widgets
//= require entities
//= require bootstrap.min

(function () {
    $(function () {

        var inputFrame = $('.input-styler');
        var datePickerFrame = $('.datepicker-toggle');
        var inputSection = $('fieldset.section');

        $('input').on('focus', function (event) {
            var target = $(event.target);

            inputFrame.removeClass('focus');
            inputSection.removeClass('focus');
            datePickerFrame.removeClass('focus');
            target.closest(inputFrame).addClass('focus');
            target.closest(inputSection).addClass('focus');
            target.closest(datePickerFrame).addClass('focus');
        });


        //UI Toggles
        var toggles = $('[data-type~="cm-toggle"]');

        $.each(toggles, function (key, value) {
            var element = $(value);
            var data = element.data();

            if (!data.target) {
                console.log('cm.toggle[error]', 'data-target must be defined', element);
                return;
            }

            var target = $('[data-section~="' + data.target + '"]');

            if (!target.length) {
                console.log('cm.toggle[error]', 'could not find target data-type="' + data.target + '"', element);
            }

            element.on('click', function (event) {
                event.preventDefault();

                if (element.hasClass('is-active')) {
                    element.removeClass('is-active');
                    target.removeClass('is-open');
                } else {
                    element.addClass('is-active');
                    target.addClass('is-open');
                }
            });
        });


        //UI Popover: based out of Bootstrap UI Component

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

        //UI Cards: accordion functionality
        var collapsingCards = $('.is-collapsible');
        var cardToggle = collapsingCards.find('.card-toggle');

        collapsingCards.addClass('is-close').removeClass('is-open');

        cardToggle.on('click', function (event) {
            event.preventDefault();

            var element = $(event.target);
            var parent = element.closest('.is-collapsible');

            collapsingCards.addClass('is-close');

            if (parent.hasClass('is-open')) {
                collapsingCards.removeClass('is-open');
            } else {
                collapsingCards.removeClass('is-open');
                parent.addClass('is-open').removeClass('is-close');
            }
        });
    });
})();

