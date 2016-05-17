function moreLess() {
  'use strict';

  // Hide the extra content initially, using JS so that if JS is disabled, no problemo.
  $('.read-more-content').addClass('hide');
}

function toggleText($this) {
  var config = {
    moreText: $this.data('more-text'),
    lessText: $this.data('less-text')
  };

  if ($this.hasClass('more')) {
    $this.removeClass('more');
    $this.html(config.lessText);
  } else {
    $this.addClass('more');
    $this.html(config.moreText);
  }
  return false;
}

$(document).ready(function(){
  'use strict';

  moreLess();
  toggleText($('.read-more-toggle'));

  // Set up the toggle.
  $('.read-more-toggle').on('click', function() {
    var $this = $(this);

    $this.next('.read-more-content').toggleClass('hide');

    toggleText($this);
  });
});
