$(document).ready(function(){
  moreless();
});

function moreless() {
// Hide the extra content initially, using JS so that if JS is disabled, no problemo.
$('.read-more-content').addClass('hide');

// Set up the toggle.
$('.read-more-toggle').on('click', function() {
  $(this).next('.read-more-content').toggleClass('hide');

  var config = {
    moreText: "More information",
    lessText: "Less information"
  };

  var $this = $(this);
  if ($this.hasClass('less')) {
    $this.removeClass('less');
    $this.html(config.moreText);
  } else {
    $this.addClass('less');
    $this.html(config.lessText);
  }
  return false;

});
}
