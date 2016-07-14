# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require jquery-ui/autocomplete
#= require autocomplete-rails

$ ->
  form_obj = $('form#unit_role_form')
  accept_role_form = $('form#accept_role_form')
  $('input#business_unit_role_email').bind 'autocompleteselect', (event, ui) ->
#    console.log(ui.item.id)
    $('input#business_unit_role_first_name').val(ui.item.first_name)
    $('input#business_unit_role_last_name').val(ui.item.last_name)
    form_obj.valid()
  .on "change paste keyup", ->
    if $(this).val() == ''
      $('input#business_unit_role_first_name').val('')
      $('input#business_unit_role_last_name').val('')
      form_obj.valid()
  $('form#unit_role_form').on("ajax:success", (e, data, status, xhr) ->
    window.location.reload()
  ).on("ajax:error", (e, data, status, xhr) ->
    $(event.data).render_form_errors( $.parseJSON(data.responseText) );
    return
  )

  if form_obj.length
    $('form#unit_role_form').validate
      errorClass: 'form-validation message error no-padding'
      errorElement: 'small'
      errorPlacement: (error, e) ->
        e.parents('fieldset').append error
        return
      highlight: (e) ->
        $(e).closest('fieldset').removeClass('invalid').addClass 'invalid'
        $(e).closest('.form-validation').remove()
        return
      success: (e) ->
        e.closest('fieldset').removeClass 'invalid'
        e.closest('.form-validation').remove()
        return
      rules:
        'business_unit_role[email]':
          required: true
          email: true
          maxlength: 128
          minlength: 3
        'business_unit_role[first_name]':
          required: true
          maxlength: 64
          minlength: 2
        'business_unit_role[last_name]':
          required: true
          maxlength: 64
          minlength: 2
      messages:
        'business_unit_role[email]': required: 'Can\'t be blank'
        'business_unit_role[first_name]': required: 'Can\'t be blank'
        'business_unit_role[last_name]': required: 'Can\'t be blank'

    $('button.submit-button').on 'click', (e) ->
      e.preventDefault()
      if form_obj.valid()
        form_obj.submit()
      else
        return false
      return

  if accept_role_form.length
    $('form#accept_role_form').validate
      errorClass: 'form-validation message error no-padding'
      errorElement: 'small'
      ignore: ''
      errorPlacement: (error, e) ->
        e.parents('fieldset').append error
        return
      highlight: (e) ->
        $(e).closest('fieldset').removeClass('invalid').addClass 'invalid'
        $(e).closest('.form-validation').remove()
        return
      success: (e) ->
        e.closest('fieldset').removeClass 'invalid'
        e.closest('.form-validation').remove()
        return
      rules:
        'tmp_cell_phone_number':
          required: true
          phoneUS: true
      messages:
        'tmp_cell_phone_number':
          required: 'Can\'t be blank'
          phoneUS: 'must be a valid phone number'

    $('button.accept-role-button').on 'click', (e) ->
      e.preventDefault()
      if accept_role_form.valid()
        accept_role_form.submit()
      else
        return false
      return
  errorObj = "<small class='form-validation message error no-padding'>must be a valid phone number</small>"
  smallObj3 = $('fieldset.business_unit_role_phone div.grid-3-12 small')
  smallObj4 = $('fieldset.business_unit_role_phone div.grid-2-12 small')
  if smallObj3.length || smallObj4.length
    smallObj3.remove() && smallObj4.remove()
    $('fieldset.business_unit_role_phone').append(errorObj)
    $('fieldset.business_unit_role_phone').addClass('invalid')

  $('input#business_unit_role_cell_area_code, input#business_unit_role_cell_prefix, input#business_unit_role_cell_line').on 'input', ->
    if $('input#business_unit_role_cell_area_code').val() != '' || $('input#business_unit_role_cell_prefix').val() != '' ||  $('input#business_unit_role_cell_line').val()
      $('input#tmp_cell_phone_number').val('+1-'+ $('input#business_unit_role_cell_area_code').val() + '-' + $('input#business_unit_role_cell_prefix').val() + '-' + $('input#business_unit_role_cell_line').val())
    else $('input#tmp_cell_phone_number').val('')
    $('input#tmp_cell_phone_number').valid()
    return
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
