$(document).ready(function($){
  'use script';
  

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

});


});

$(document).foundation({
"magellan-expedition": {
  destination_threshold: 60, // pixels from the top of destination for it to be considered active
  fixed_top: 60, // top distance in pixels assigned to the fixed element on scroll
}

});
