# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require jquery-ui/autocomplete
#= require autocomplete-rails

$ ->
  $('input#account_manager_email').bind 'autocompleteselect', (event, ui) ->
#    console.log(ui.item.id)
    $('input#account_manager_first_name').val(ui.item.first_name)
    $('input#account_manager_last_name').val(ui.item.last_name)
    form_obj.valid()
  .on "change paste keyup", ->
    if $(this).val() == ''
      $('input#account_manager_first_name').val('')
      $('input#account_manager_last_name').val('')
      form_obj.valid()
  $('div.icon-email-full').click ->
    $('div.preview-email-input').fadeToggle('slow')

  form_obj = $('form#am_form')
  if form_obj.length
    $('form#am_form').validate
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
        'account_manager[email]':
          required: true
          email: true
          maxlength: 128
          minlength: 3
        'account_manager[first_name]':
          required: true
          maxlength: 64
          minlength: 2
        'account_manager[last_name]':
          required: true
          maxlength: 64
          minlength: 2
      messages:
        'account_manager[email]': required: 'Can\'t be blank'
        'account_manager[first_name]': required: 'Can\'t be blank'
        'account_manager[last_name]': required: 'Can\'t be blank'
  $('button.am-button').on 'click', (e) ->
    e.preventDefault()
    if form_obj.valid()
      form_obj.submit()
    else
      return false
  $('[data-name="invite-am-modal"] a.button-primary').click (e) ->
    window.location.href = $(this).attr('data-target')
  $('[data-name="invite-am-modal"] a.button-secondary').click (e) ->
    window.location.href = $(this).attr('data-target')
  return

read_image = (input, wrapClass) ->
  if input.files && input.files[0]
    ext = $(input).val().split('.').pop().toLowerCase()

    if $.inArray(ext, ['gif','png','jpg','jpeg']) == -1
      alert 'invalid extension!'
      return false

    reader = new FileReader()

    reader.onload = (e) ->
      $('figure.' + wrapClass + ' img').attr('src', e.target.result)

    reader.readAsDataURL(input.files[0])