# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require dropzone

class @Attachment
  @ATTACHMENT_IDS: []
  dropzone_define: (element) ->
    type = 'article'
    if $('form.comment_form').length then type = "comment"

    Dropzone.autoDiscover = false;
  #  mediaDropzone = []
  #    _this = this

    mediaDropzone = new Dropzone(element, {
      url: $(element).attr('data_url')
      paramName: "attachment"
      addRemoveLinks: true
    })
    mediaDropzone.on "sending", (file, xhr, data) ->
      data.append("authenticity_token", $('input[name=authenticity_token').val())
      data.append("attach_type", type)
    mediaDropzone.on 'complete', (file, response) ->

      if file.status == 'success'
        Attachment.ATTACHMENT_IDS.push(JSON.parse(file.xhr.response).id)
        $(file.previewTemplate).find('.dz-remove').attr('id', JSON.parse(file.xhr.response).id)
      else
        message_template = ''
        $.each(JSON.parse(file.xhr.response), (field, messages) ->
          message_template += '<p>' + messages + '</p>'
          return
        )
        $(file.previewTemplate).find('div.dz-error-message').find('span').html(message_template)
        setTimeout( ->
          $(file.previewTemplate).fadeOut('slow', ->
            mediaDropzone.removeFile(file);
          )
        , 5000)
  #    appendContent responseText.file_name.url, responseText.id
      return

    # when the remove button is clicked
    mediaDropzone.on 'removedfile', (file) ->
      id = $(file.previewTemplate).find('.dz-remove').attr('id')

      $.ajax({
        type: 'DELETE'
        url: '/articles/destroy_attachment'
        data:
          attachment_id: id
          attach_type: type
        success: (file) ->
          $(file.previewTemplate).fadeOut()
          i = Attachment.ATTACHMENT_IDS.indexOf(id*1)
          if i != -1
            Attachment.ATTACHMENT_IDS.splice(i, 1)
          return
      })
      return

    $('form#article_form, form.comment_form, form.edit-comment-form').unbind('submit').on 'submit', ->
      $(this).find('input[name=attachment_ids]').remove()
      $(this).append("<input type='hidden' name='attachment_ids' value='" + Attachment.ATTACHMENT_IDS + "'>")
      Attachment.ATTACHMENT_IDS = []
    return