$(document).ready(function($){
  'use script';
  
window.onresize = function(event) {
resizeDiv();
}

// Scrolling to anchor links
$(function() {
  $('a[href*=#]:not([href=#])').click(function() {

    if (location.pathname.replace(/^\//,'') === this.pathname.replace(/^\//,'') 
      && location.hostname === this.hostname) {
      var target = $(this.hash);

      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');

      if (target.length) {
        $('html,body').animate({
          scrollTop: target.offset().top
        }, 1000);

        return false;
      }
    }
  });

resizeDiv();

});

function resizeDiv() {
var vpw = $(window).width();
var vph = $(window).height();
$('.screen').css({'height': vph + 'px'});
}

});

$(document).foundation({
"magellan-expedition": {
  destination_threshold: 60, // pixels from the top of destination for it to be considered active
  fixed_top: 60, // top distance in pixels assigned to the fixed element on scroll
}
});
