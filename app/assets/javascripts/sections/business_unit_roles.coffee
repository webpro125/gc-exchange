# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require jquery-ui/autocomplete
#= require autocomplete-rails

$ ->
  $('input#business_unit_role_email').bind 'autocompleteselect', (event, ui) ->
#    console.log(ui.item.id)
    $('input#business_unit_role_first_name').val(ui.item.first_name)
    $('input#business_unit_role_last_name').val(ui.item.last_name)
  .on "change paste keyup", ->
    if $(this).val() == ''
      $('input#business_unit_role_first_name').val('')
      $('input#business_unit_role_last_name').val('')

  $('form#unit_role_form').on("ajax:success", (e, data, status, xhr) ->
    window.location.reload()
  ).on("ajax:error", (e, data, status, xhr) ->
    $(event.data).render_form_errors( $.parseJSON(data.responseText) );
    return
  )

  errorObj = "<small class='form-validation message error no-padding'>must be a valid phone number</small>"
  smallObj3 = $('fieldset.business_unit_role_phone div.grid-3-12 small')
  smallObj4 = $('fieldset.business_unit_role_phone div.grid-2-12 small')
  if smallObj3.length || smallObj4.length
    smallObj3.remove() && smallObj4.remove()
    $('fieldset.business_unit_role_phone').append(errorObj)
    $('fieldset.business_unit_role_phone').addClass('invalid')

  return

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
