$ ->
  smallObj = $('fieldset.account_manager_phone div.grid-3-12 small, fieldset.account_manager_phone div.grid-2-12 small')
  errorObj = "<small class='form-validation message error no-padding'>must be a valid phone number</small>"
  if smallObj.length
    smallObj.remove()
    $('fieldset.account_manager_phone').append(errorObj)
    $('fieldset.account_manager_phone').addClass('invalid')