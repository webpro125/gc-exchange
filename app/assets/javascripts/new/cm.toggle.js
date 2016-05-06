(function () {
    $(function () {
        var eventEmitter = $(document);
        var toggles = $('[data-type~="cm-toggle"]');
        var knownSections = {};

        var slideOutElement = function (element) {
            element.addClass('is-sliding');
            var height = element.outerHeight();
            element.css({height: 0});

            element.animate({
                height: height
            }, {
                duration: 250,
                queue: false,
                complete: function () {
                    element.removeClass('is-sliding');
                    element.css({height: 'auto'});
                }
            });
        };

        var slideInElement = function (element) {
            if (element.hasClass('is-open')) {
                element.addClass('is-sliding');
                element.animate({
                    height: 0
                }, {
                    duration: 250,
                    queue: false,
                    complete: function () {
                        element.removeClass('is-sliding');
                        element.css({height: 'auto'});
                    }
                });
            }
        };

        var closeAllToggles = function () {
            _.each(knownSections, function (section) {
                if (!section['ignore_global_close']) {
                    _.each(section['toggles'], function (toggle) {
                        $(toggle).removeClass('is-open connect-down');
                    });

                    _.each(section['targets'], function (sectionItem) {
                        var target = $(sectionItem);

                        slideInElement(target.filter('[data-slide-open]'));
                        target.removeClass('is-open');
                    });
                }
            });

            eventEmitter.trigger('cm.toggle.close', {
                sections: knownSections
            });
        };

        $(document).on('click', function (event) {
            var target = $(event.target).closest('[data-toggle-container]');

            if (target.length === 0) {
                closeAllToggles();
            }
        });

        _.each(toggles, function (value) {
            var element = $(value);
            var data = element.data();

            if (!data.target) {
                dump('cm.toggle[error]', 'data-target must be defined', element);
                return;
            }

            var target = $('[data-section~="' + data.target + '"]');

            if (!target.length) {
                dump('cm.toggle[error]', 'could not find target data-section="' + data.target + '"', element);
            }

            if (!knownSections[data.target]) {
                knownSections[data.target] = {
                    toggles: [],
                    targets: {},
                    ignore_global_close: undefined
                };
            }

            knownSections[data.target]['toggles'].push(element);
            knownSections[data.target]['targets'] = target;
            knownSections[data.target]['ignore_global_close'] = data['ignoreGlobalClose'];

            element.on('click', function (event) {
                event.preventDefault();

                var sectionName = data.target;
                var section = knownSections[sectionName];
                var sectionEventData = {};
                sectionEventData[sectionName] = section;
                var hasOpen = false;

                _.each(section['toggles'], function (toggle) {
                    var element = $(toggle);
                    if (element.hasClass('is-open')) {
                        hasOpen = true;
                    }
                });

                if (hasOpen) {
                    _.each(section.toggles, function (value) {
                        $(value).removeClass('is-open connect-down');
                    });
                    slideInElement(target.filter('[data-slide-open]'));
                    target.removeClass('is-open');

                    eventEmitter.trigger('cm.toggle.close', sectionEventData);
                } else {
                    closeAllToggles();
                    _.each(section.toggles, function (value) {
                        $(value).addClass('is-open connect-down');
                    });

                    slideOutElement(target.filter('[data-slide-open]'));

                    target.addClass('is-open');

                    eventEmitter.trigger('cm.toggle.open', sectionEventData);
                }
            });
        });
    });
})();
