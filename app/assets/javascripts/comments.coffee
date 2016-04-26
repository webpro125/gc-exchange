# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require articles
$ ->
  define_event()

define_event = ->
  $('a.edit-comment').unbind('click').click (e) ->
    e.preventDefault()
    $(this).closest('div.timeline-comment-wrapper').find('div.comment-body').hide()
    $(this).closest('div.timeline-comment-wrapper').find('form.simple_form').show(400)

  $('button.cancel-edit').unbind('click').click (e) ->
    $(this).closest('div.timeline-comment-wrapper').find('form.simple_form').hide()
    $(this).closest('div.timeline-comment-wrapper').find('div.comment-body').show(400)

  $('form.edit-comment-form').on("ajax:success", (e, data, status, xhr) ->
#    $(this).closest('div.timeline-comment-wrapper').find('div.comment-body p').html(data.body.replace(new RegExp('\r?\n','g'), '<br />'))
    comment_wrapper = $(this).closest('div.timeline-comment-wrapper')
    comment_wrapper.find('form.simple_form').hide()
    $.get('/comments/' + data.id + '/load_comment', (response, status) ->
      comment_wrapper.find('div.comment-content').html(response, ->
        comment_wrapper.find('div.comment-body').show(400)
      )
      define_event()
      unless comment_wrapper.find('div.dz-default.dz-message').length
        attachment = new Attachment()
        comment_wrapper.find("div#attach_file").each (index, element) ->
          attachment.dropzone_define(element)
    )
  ).on "ajax:error", (e, xhr, status, error) ->
    $('form.edit-comment-form').append "<p>ERROR</p>"