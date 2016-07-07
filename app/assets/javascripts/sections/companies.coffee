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
#    $.validator.addMethod 'totalCheck', ((value, element, params) ->
#      field_1 = $('input[name="' + params[0] + '"]')
#      field_2 = $('input[name="' + params[1] + '"]')
#
##      if field_1 != '' || field_2 != ''
##        parseInt(field_1) && parseInt(field_2) && $(element).val().toString().length == 3
##      else return false
#      field_1.valid() && field_2.valid()
#    ), 'Enter the number of persons (including yourself)'
    $('form#reg_company_form').validate
      errorClass: 'form-validation message error no-padding'
      errorElement: 'small'
      onkeyup: false
      onfocusout: false
      errorPlacement: (error, element) ->
        if element.attr("name") == "requested_company[work_area_code]" || element.attr("name") == "requested_company[work_prefix]" || element.attr("name") == "requested_company[work_line]"
          if element.closest('fieldset').find('small.form-validation').length
            element.closest('fieldset').find('small.form-validation').text(error.text())
          else error.appendTo(element.closest('fieldset'))
        else error.appendTo(element.closest('fieldset'))
        return
      highlight: (e) ->
        $(e).closest('fieldset').removeClass('invalid').addClass 'invalid'
#        $(e).closest('.form-validation').remove()
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
          number: true
          minlength: 3
          maxlength: 3
        'requested_company[work_prefix]':
          required: true
          number: true
          minlength: 3
          maxlength: 3
        'requested_company[work_line]':
          required: true
          minlength: 4
          maxlength: 4
          number: true
        'requested_company[cell_area_code]':
          number: true
          minlength: 3
          maxlength: 3
        'requested_company[cell_prefix]':
          number: true
          minlength: 3
          maxlength: 3
        'requested_company[cell_line]':
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
          totalCheck: 'must be a valid phone numbe1234r'
          minlength: 'must be a valid phone number'
          maxlength: 'must be a valid phone number'
        'requested_company[cell_line]':
          number: 'must be a valid phone number'
          totalCheck: 'must be a valid phone number'
          minlength: 'must be a valid phone number'
          maxlength: 'must be a valid phone number'
        'requested_company[help_content]':
          required: 'Can\'t be blank'
      groups:
        nameGroup: "requested_company_work_area_code requested_company_work_prefix requested_company_work_line"
  $('button.register-button').on 'click', (e) ->
    e.preventDefault()
    if form_obj.valid()
      form_obj.submit()
    else
      return false

  return