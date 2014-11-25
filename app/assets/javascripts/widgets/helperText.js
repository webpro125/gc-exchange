$(document).ready(function() {
  $(':input').on('focus', function() {
    $(this).siblings('.hint').transition({
      opacity: 100
    }, 500, 'in');
  });

  $(':input').on('blur', function() {
    var ele = $(this);

    ele.siblings('.hint')
        .transition({
          opacity: 0
        }, 500, 'out');
  });

  $(':input').each(function(i, e) {
    var ele = $(e);

    ele.siblings('.hint').transition({
      opacity: 0
    }, 500, 'out');
  });
});
