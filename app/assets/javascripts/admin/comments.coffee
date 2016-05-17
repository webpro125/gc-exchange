# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require sections/articles

$ ->
  $('a.edit-comment').unbind('click').click (e) ->
    e.preventDefault()
    $(this).closest('div.social-feed-box').find('div.comment-content').hide()
    $(this).closest('div.social-feed-box').find('form.simple_form').show(400)
    return

  define_event()
  return
define_event = ->

  $('button.cancel-edit').unbind('click').click (e) ->
    $(this).closest('div.social-feed-box').find('form.simple_form').hide()
    $(this).closest('div.social-feed-box').find('div.comment-content').show(400)

  $('form.edit-comment-form').on("ajax:success", (e, data, status, xhr) ->
#    $(this).closest('div.social-feed-box').find('div.comment-content p').html(data.body.replace(new RegExp('\r?\n','g'), '<br />'))
    comment_wrapper = $(this).closest('div.social-feed-box')
    comment_wrapper.find('form.simple_form').hide()
    $.get('/admin/comments/' + data.id + '/load_comment', (response, status) ->
      comment_wrapper.find('div.social-body').html(response, ->
        comment_wrapper.find('div.comment-content').show(400)
      )
      define_event()
      unless comment_wrapper.find('div.dz-default.dz-message').length
        attachment = new Attachment()
        comment_wrapper.find("div#attach_file").each (index, element) ->
          attachment.dropzone_define(element)
    )
  ).on "ajax:error", (e, xhr, status, error) ->
    $('form.edit-comment-form').append "<p>ERROR</p>"
