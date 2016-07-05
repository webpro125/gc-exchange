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
        'account_manager[business_unit_name]':
          required: true
          maxlength: 64
          minlength: 2
        'account_manager[cell_area_code]':
          required: true
          totalCheck: ['account_manager[cell_prefix]', 'account_manager[cell_line]']
          number: true
          minlength: 3
          maxlength: 3
        'account_manager[cell_prefix]':
          required: true
          totalCheck: ['account_manager[cell_line]', 'account_manager[cell_area_code]']
          number: true
          minlength: 3
          maxlength: 3
        'account_manager[cell_line]':
          required: true
          totalCheck: ['account_manager[cell_prefix]', 'account_manager[cell_area_code]']
          number: true
          minlength: 4
          maxlength: 4
      messages:
        'account_manager[business_unit_name]': required: 'Can\'t be blank'
        'account_manager[cell_area_code]':
          required: 'Can\'t be blank'
          number: 'must be a valid phone number'
          totalCheck: 'must be a valid phone number'
          minlength: 'must be a valid phone number'
          maxlength: 'must be a valid phone number'
        'account_manager[cell_prefix]':
          required: 'Can\'t be blank'
          number: 'must be a valid phone number'
          totalCheck: 'must be a valid phone number'
          minlength: 'must be a valid phone number'
          maxlength: 'must be a valid phone number'
        'account_manager[cell_line]':
          required: 'Can\'t be blank'
          number: 'must be a valid phone number'
          totalCheck: 'must be a valid phone number'
          minlength: 'must be a valid phone number'
          maxlength: 'must be a valid phone number'
  $('button.register-button').on 'click', (e) ->
    e.preventDefault()
    if form_obj.valid()
      form_obj.submit()
    else
      return false