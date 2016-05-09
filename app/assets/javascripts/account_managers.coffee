# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require jquery-ui/autocomplete
#= require autocomplete-rails

$ ->
  $("input#account_manager_avatar").change ->
    read_image(this, 'profile-thumb')

  $('input#business_unit_role_email').bind 'autocompleteselect', (event, ui) ->
#    console.log(ui.item.id)
    $('input#business_unit_role_first_name').val(ui.item.first_name)
    $('input#business_unit_role_last_name').val(ui.item.last_name)
  .on "change paste keyup", ->
    if $(this).val() == ''
      $('input#business_unit_role_first_name').val('')
      $('input#business_unit_role_last_name').val('')

  $('input#account_manager_email').bind 'autocompleteselect', (event, ui) ->
#    console.log(ui.item.id)
    $('input#account_manager_first_name').val(ui.item.first_name)
    $('input#account_manager_last_name').val(ui.item.last_name)
  .on "change paste keyup", ->
    if $(this).val() == ''
      $('input#account_manager_first_name').val('')
      $('input#account_manager_last_name').val('')

  $('div.icon-email-full').click ->
    $('div.preview-email-input').fadeToggle('slow')
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