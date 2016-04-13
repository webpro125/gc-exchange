# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('a.edit-comment').click (e) ->
    e.preventDefault()
    $(this).closest('div.social-feed-box').find('div.comment-content').hide()
    $(this).closest('div.social-feed-box').find('form.simple_form').show(400)

  $('button.cancel-edit').click (e) ->
    $(this).closest('div.social-feed-box').find('form.simple_form').hide()
    $(this).closest('div.social-feed-box').find('div.comment-content').show(400)

  $('form.edit-comment-form').on("ajax:success", (e, data, status, xhr) ->
    $(this).closest('div.social-feed-box').find('div.comment-content p').html(data.body.replace(new RegExp('\r?\n','g'), '<br />'))
    $(this).closest('div.social-feed-box').find('form.simple_form').hide()
    $(this).closest('div.social-feed-box').find('div.comment-content').show(400)
  ).on "ajax:error", (e, xhr, status, error) ->
    $('form.edit-comment-form').append "<p>ERROR</p>"

#    $.rails.handleRemote( $(this) );