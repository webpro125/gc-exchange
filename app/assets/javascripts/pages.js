$(document).ready(function($){
  'use script';
  
window.onresize = function(event) {
resizeDiv();
}

$('#progress li a').on('click', function(){
    $('li a.current').removeClass('current');
    $(this).addClass('current');
});

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
