# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('form.project-form section.card-section div.radio.ui-checkbox').each (index, element) ->
    label_for = $(element).find('label').attr('for')
    input_html = $(element).find('input')
    label_name = $(element).find('label').text();
    label_wrapper = "<label for='" + label_for + "'>" + label_name + "</label>"
    $(element).html(input_html).append(label_wrapper)
    return

  $('form.project-form fieldset.project_proposed_rate').append(
    """
      <div class="grid-4-12">
        <p>Enter Alternative Consultant Hourly Rate to Negotiate</p>
      </div>
    """
  )

  $('input#sow_file').change ->
    if !window.File or !window.FileReader or !window.FileList or !window.Blob
      alert 'The File APIs are not fully supported in this browser.'
      return
    input = document.getElementById('sow_file')
    if !input
      alert 'Um, couldn\'t find the fileinput element.'
    else if !input.files
      alert 'This browser doesn\'t seem to support the `files` property of file inputs.'
    else if !input.files[0]
      alert 'Please select a file before clicking \'Load\''
    else
      file = input.files[0]
      fr = new FileReader
      #fr.onload = receivedText;
      #fr.readAsText(file);
      fr.readAsDataURL file
      upload_file_html = '<li class="upload-item">'
      upload_file_html += file.name
      upload_file_html += '<span>' + formatBytes(file.size) + '</span>'
      upload_file_html += '<button class="icon-cr-cross-light remove-upload">Remove</button></li>'
      $('ul.upload-list').html(upload_file_html)
      define_remove_upload_event()
    return
  $('div.project_consultant_location input').each (index, element) ->
    show_work_location($(element))

  $('div.project_consultant_location input').click ->
    show_work_location($(this))

  return
define_remove_upload_event = () ->
  $('button.remove-upload').unbind('click').click ->
    $(this).closest('li').remove()
    $('input#sow_file').val('')
  return

formatBytes = (bytes, decimals) ->
  if bytes == 0
    return '0 Byte'
  k = 1000
  dm = decimals + 1 or 2
  sizes = [
    'Bytes'
    'KB'
    'MB'
    'GB'
    'TB'
    'PB'
    'EB'
    'ZB'
    'YB'
  ]
  i = Math.floor(Math.log(bytes) / Math.log(k))
  parseFloat((bytes / k ** i).toFixed(dm)) + ' ' + sizes[i]

show_work_location = (input_obj) ->
  if input_obj.val() == 'Remote' && input_obj.prop('checked')
    input_obj.closest('div.project_consultant_location').next().hide()
  else if input_obj.prop('checked')
    input_obj.closest('div.project_consultant_location').next().show()