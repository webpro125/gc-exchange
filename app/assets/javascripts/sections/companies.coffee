# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require jquery-ui/autocomplete
#= require autocomplete-rails

$ ->
  smallObj1 = $('fieldset.requested_company_work_phone div.grid-3-12 small')
  smallObj2 = $('fieldset.requested_company_work_phone div.grid-2-12 small')
  errorObj = "<small class='form-validation message error no-padding'>must be a valid phone number</small>"
  if smallObj1.length || smallObj2.length
    smallObj1.remove() && smallObj2.remove()
    $('fieldset.requested_company_work_phone').append(errorObj)
    $('fieldset.requested_company_work_phone').addClass('invalid')

  smallObj3 = $('fieldset.requested_company_cell_phone div.grid-3-12 small')
  smallObj4 = $('fieldset.requested_company_cell_phone div.grid-2-12 small')
  if smallObj3.length || smallObj4.length
    smallObj3.remove() && smallObj4.remove()
    $('fieldset.requested_company_cell_phone').append(errorObj)
    $('fieldset.requested_company_cell_phone').addClass('invalid')


  form_obj = $('form#reg_company_form')
  if form_obj.length
    $.validator.addMethod 'totalCheck', ((value, element, params) ->
      field_1 = $('input[name="' + params[0] + '"]').val()
      field_2 = $('input[name="' + params[1] + '"]').val()
      if field_1 != '' || field_2 != ''
        parseInt(field_1) && parseInt(field_2)
      else return true
    ), 'Enter the number of persons (including yourself)'
    $('form#reg_company_form').validate
      errorClass: 'form-validation message error no-padding'
      errorElement: 'small'
      errorPlacement: (error, e) ->
        if !e.parents('fieldset').find('small.form-validation').length
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
        'requested_company[company_name]':
          required: true
          maxlength: 128
        'requested_company[work_area_code]':
          required: true
          totalCheck: ['requested_company[work_prefix]', 'requested_company[work_line]']
          number: true
          minlength: 3
          maxlength: 3
        'requested_company[work_prefix]':
          required: true
          totalCheck: ['requested_company[work_line]', 'requested_company[work_area_code]']
          number: true
          minlength: 3
          maxlength: 3
        'requested_company[work_line]':
          required: true
          minlength: 4
          maxlength: 4
          totalCheck: ['requested_company[work_prefix]', 'requested_company[work_area_code]']
          number: true
        'requested_company[cell_area_code]':
          totalCheck: ['requested_company[cell_prefix]', 'requested_company[cell_line]']
          number: true
          minlength: 3
          maxlength: 3
        'requested_company[cell_prefix]':
          totalCheck: ['requested_company[cell_line]', 'requested_company[cell_area_code]']
          number: true
          minlength: 3
          maxlength: 3
        'requested_company[cell_line]':
          totalCheck: ['requested_company[cell_prefix]', 'requested_company[cell_area_code]']
          number: true
          minlength: 4
          maxlength: 4
        'requested_company[help_content]':
          required: true
          minlength: 2
          maxlength: 500
      messages:
        'requested_company[company_name]':
          required: 'Can\'t be blank'
          maxlength: 128
        'requested_company[work_area_code]':
          required: 'Can\'t be blank'
          number: 'must be a valid phone number'
          totalCheck: 'must be a valid phone number'
          minlength: 'must be a valid phone number'
          maxlength: 'must be a valid phone number'
        'requested_company[work_prefix]':
          required: 'Can\'t be blank'
          number: 'must be a valid phone number'
          totalCheck: 'must be a valid phone number'
          minlength: 'must be a valid phone number'
          maxlength: 'must be a valid phone number'
        'requested_company[work_line]':
          required: 'Can\'t be blank'
          number: 'must be a valid phone number'
          totalCheck: 'must be a valid phone number'
          minlength: 'must be a valid phone number'
          maxlength: 'must be a valid phone number'
        'requested_company[cell_area_code]':
          number: 'must be a valid phone number'
          totalCheck: 'must be a valid phone number'
          minlength: 'must be a valid phone number'
          maxlength: 'must be a valid phone number'
        'requested_company[cell_prefix]':
          number: 'must be a valid phone number'
          totalCheck: 'must be a valid phone number'
          minlength: 'must be a valid phone number'
          maxlength: 'must be a valid phone number'
        'requested_company[cell_line]':
          number: 'must be a valid phone number'
          totalCheck: 'must be a valid phone number'
          minlength: 'must be a valid phone number'
          maxlength: 'must be a valid phone number'
        'requested_company[help_content]':
          required: 'Can\'t be blank'
  $('button.register-button').on 'click', (e) ->
    e.preventDefault()
    if form_obj.valid()
      form_obj.submit()
    else
      return false

  return