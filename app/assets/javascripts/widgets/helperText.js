(function() {
  $(':input').on('focus', function() {
    $(this).siblings('.hint').removeClass('hide');
  });

  $(':input').on('blur', function() {
    $(this).siblings('.hint').addClass('hide');
  });
})();
