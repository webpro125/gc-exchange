(($) ->
  $.fn.modal_success = ->
# close modal
    @modal 'hide'
    # clear form input elements
    # todo/note: handle textarea, select, etc
    @find('form input[type="text"]').val ''
    # clear error state
    @clear_previous_errors()
    return

  $.fn.render_form_errors = (errors) ->
    $form = this
    @clear_previous_errors()
    #model = @data('model')
    model = 'business_unit_role'
    # show error messages in input form-group help-block
    $.each errors, (field, messages) ->
      $input = $('input[name="' + model + '[' + field + ']"]')
      tmpHtml = "<small class='form-validation message error'>" + messages[0] + "</small>"
      if $input.closest('fieldset').length
        $input.closest('fieldset').find('small.form-validation').remove()
        $input.closest('fieldset').addClass('invalid').append tmpHtml
      else
        $input.closest('section').find('small.form-validation').remove()
        $input.closest('section').addClass('invalid').append tmpHtml
      return
    return

  $.fn.clear_previous_errors = ->
    $('section.invalid').each ->
      $(this).find('small.form-validation').remove()
      $(this).removeClass 'invalid'
      return
    $('fieldset.invalid').each ->
      $(this).find('small.form-validation').remove()
      $(this).removeClass 'invalid'
      return
    return

  return
) jQuery