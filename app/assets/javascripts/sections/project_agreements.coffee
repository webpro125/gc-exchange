# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('form.project-agreement-form section.card-section div.radio.ui-checkbox').each (index, element) ->
    label_for = $(element).find('label').attr('for')
    input_html = $(element).find('input')
    label_name = $(element).find('label').text();
    label_wrapper = "<label for='" + label_for + "'>" + label_name + "</label>"
    $(element).html(input_html).append(label_wrapper)

    reason_box_toggle($(element), $(element).find('input'))

    $(element).find('input').click ->
      reason_box_toggle($(element), $(this))
    return

  $('form.project-form fieldset.project_proposed_rate').append(
                                                              """
      <div class="grid-4-12">
        <p>Enter Alternative Consultant Hourly Rate to Negotiate</p>
      </div>
    """
  )

reason_box_toggle = (checkbox_wrapper, input_obj) ->
  if input_obj.val() == 'false' && input_obj.prop("checked")
    checkbox_wrapper.closest('section.card-section').find('div.section-thread').show()
    checkbox_wrapper.removeClass('textarea-toggle is-open').addClass('textarea-toggle is-open')
  else if input_obj.prop("checked")
    checkbox_wrapper.closest('section.card-section').find('div.section-thread').hide()
    checkbox_wrapper.closest('div.radio_buttons').find('div.ui-checkbox').removeClass('textarea-toggle is-open')