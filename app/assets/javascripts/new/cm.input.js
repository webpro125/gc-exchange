(function ($) {
    $(function () {
        var inputFrame = $('.input-styler');
        var datePickerFrame = $('.datepicker-toggle');
        var inputSection = $('fieldset.section');

        $('input').on('focus', function (event) {
            var target = $(event.target);

            inputFrame.removeClass('focus');
            inputSection.removeClass('focus');
            datePickerFrame.removeClass('focus');
            target.parent(inputFrame).addClass('focus');
            target.closest(inputSection).addClass('focus');
            target.closest(datePickerFrame).addClass('focus');
        });
    });
})(jQuery);
