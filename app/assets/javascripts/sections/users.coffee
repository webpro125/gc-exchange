$ ->
  smallObj = $('fieldset.account_manager_phone div.grid-3-12 small, fieldset.account_manager_phone div.grid-2-12 small')
  errorObj = "<small class='form-validation message error no-padding'>must be a valid phone number</small>"
  if smallObj.length
    smallObj.remove()
    $('fieldset.account_manager_phone').append(errorObj)
    $('fieldset.account_manager_phone').addClass('invalid')

  form_obj = $('form#reg_am_form')
  if form_obj.length
    $.validator.addMethod 'totalCheck', ((value, element, params) ->
      field_1 = $('input[name="' + params[0] + '"]').val()
      field_2 = $('input[name="' + params[1] + '"]').val()
      parseInt(field_1) && parseInt(field_2)
    ), 'Enter the number of persons (including yourself)'

    $('form#reg_am_form').validate
      ignore: ''
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
        'account_manager[business_unit_name]':
          required: true
          maxlength: 64
          minlength: 2
        'tmp_cell_phone_number':
          required: true
          phoneUS: true
      messages:
        'account_manager[business_unit_name]': required: 'Can\'t be blank'
        'tmp_cell_phone_number':
          required: 'Can\'t be blank'
          phoneUS: 'must be a valid phone number'
  $('button.register-button').on 'click', (e) ->
    e.preventDefault()
    if form_obj.valid()
      form_obj.submit()
    else
      return false
    return
  $('input#account_manager_cell_area_code, input#account_manager_cell_prefix, input#account_manager_cell_line').on 'input', ->
    $('input#tmp_cell_phone_number').val('+1-'+ $('input#account_manager_cell_area_code').val() + '-' + $('input#account_manager_cell_prefix').val() + '-' + $('input#account_manager_cell_line').val())
    $('input#tmp_cell_phone_number').valid()
    return