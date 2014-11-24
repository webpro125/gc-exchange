(function() {
  'use strict';

  $.widget('custom.select2Dropdown', {
    _create: function() {
      this.ele = $(this.element);

      this.ele.select2(this._buildSelectOptions());
    },
    _buildAjax: function(opts) {
      var self = this;

      opts.minimumInputLength = 1;

      opts.ajax = {
        url: self.ele.data('url'),
        dataType: 'json',
        quietMills: 300,
        data: function(term, page) {
          return {
            q: term,
            page: page
          };
        },
        results: function(data, page) {
          var more = (page * 25) < data.total_count;

          return {
            results: data.items,
            page: page,
            more: more
          };
        }
      };

      opts.formatResult = function(item) {
        if(typeof item === 'string') {
          return item;
        }else{
          return item.text;
        }
      };

      opts.formatSelection = function(item) {
        return item.text;
      };

      opts.initSelection = function(element, callback) {
        // the input tag has a value attribute preloaded that points to a preselected repository's id
        // this function resolves that id attribute to an object that select2 can render
        // using its formatResult renderer - that way the repository name is shown preselected
        var data = [];
        $(element.val().split(',')).each(function () {
          data.push({
            id: $.trim(this),
            text: $.trim(this)
          });
        });

        callback(data);
      };
    },
    _buildTags: function(opts) {
      var self = this;

      opts.tags = self.ele.data('tags');

      opts.createSearchChoice = function(term, data) {
        if ($(data).filter(function() {
          if(typeof this === 'string') {
            return this.localeCompare(term) === 0;
          }else{
            return this.text.localeCompare(term) === 0;
          }
        }).length === 0) {
          return {
            id: term,
            text: term
          };
        }
      };
    },
    _buildSelectOptions: function() {
      var self = this;

      var opts = {
        width: 'element',
        minimumResultsForSearch: 10,
        closeOnSelect: false,
        dropdownCssClass: "bigdrop", // apply css that makes the dropdown taller
        tokenSeparators: [',']
      };

      if(self.ele.data('tags')) {
        self._buildTags(opts);
      }

      if(self.ele.data('url')) {
        self._buildAjax(opts);
      }

      if(self.ele.data('maximumselectionsize')) {
        opts.maximumSelectionSize = self.ele.data('maximumselectionsize');
        if(self.ele.data('maxsizeerrormessage')) {
           opts.formatSelectionTooBig = function(maxSize) {
             return self.ele.data('maxsizeerrormessage').replace('%{count}', maxSize);
           }
        }
      }

      return opts;
    }
  });
})();
