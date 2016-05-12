(function ($) {
    $(function () {
        var positions = {
            1: {box: 'community', connection: false, delay: 3000},
            2: {box: 'selection', connection: 'one', delay: 4000},
            3: {box: 'requisition', connection: 'two', delay: 4000},
            4: {box: 'approval', connection: 'three', delay: 4000},
            5: {box: 'work', connection: 'four', delay: 4000}
        };

        var automatedWorkflow = $('.automated-workflow-process');
        var docDraft = $('.doc-draft');
        var boxes = {};

        var switchPosition = function (position) {
            _.map(boxes, function (item, key) {
                var positionName = 'position-' + positions[key].connection;

                if (key < position) {
                    if (item.connection) {
                        docDraft.removeClass(positionName);
                    }

                    item.box.removeClass('is-active').addClass('is-visited');
                }

                if (key <= position) {
                    if (item.connection) {
                        item.connection.addClass('is-on');
                    }
                }

                if (key == position) {
                    if (item.connection) {
                        docDraft.addClass(positionName);
                    }

                    item.box.addClass('is-active');
                }

                if (key > position) {
                    if (item.connection) {
                        item.connection.removeClass('is-on');
                        docDraft.removeClass(positionName);
                    }

                    item.box.removeClass('is-active is-visited');
                }
            });
        };

        var interval = {
            initialized: false,
            paused: false,
            running: false,
            first: 0,
            last: 0,
            position: 0,
            initialize: function () {
                var keys = Object.keys(positions);

                this.initialized = true;
                this.first = _.min(keys);
                this.last = _.max(keys);
            },
            pause: function () {
                this.paused = true;
            },
            start: function () {
                this.paused = false;

                if (!this.initialized) this.initialize();
                if (!this.running) this.startInterval();
            },
            startInterval: function () {
                this.running = !this.paused;

                if (!this.paused && this.running) {
                    this.position = this.position >= this.last ? this.first : ++this.position;

                    switchPosition(this.position);
                    setTimeout(this.startInterval.bind(this), positions[this.position].delay);
                }
            }
        };

        _.delay(interval.start.bind(interval), 2000);

        _.each(positions, function (item, key) {
            var connection = item.connection ? automatedWorkflow.find('.connection-' + item.connection) : false;

            boxes[key] = {
                box: automatedWorkflow.find('.box-' + item.box),
                connection: connection
            };

            boxes[key].box.on('mouseenter', function () {
                interval.pause();
                switchPosition(key);
            });

            boxes[key].box.on('mouseleave', function () {
                interval.position = key;
                interval.start();
            });
        });
    });
})(jQuery);
