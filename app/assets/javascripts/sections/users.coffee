$ ->
  $('a.company-registration').click (e) ->
    if $(this).attr('href') == '#'
      e.preventDefault()
      $('section.registration-fail-modal').show()
  $('a[data-modal-close]').click (e) ->
    $(this).closest('section.ui-modal').hide()
    return