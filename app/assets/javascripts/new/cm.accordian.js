(function ($) {
    $(function () {
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
})(jQuery);
