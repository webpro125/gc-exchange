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