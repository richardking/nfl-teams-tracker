# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class @CommentView extends Backbone.View
  template: JST['templates/comment']

  initialize: ->
    @model.on('change', @render, this)

  render: ->
    this.$el.html(@template(comment: @model)).hide().fadeIn(1000)
    this

class @CommentsView extends Backbone.View
  template: JST['templates/comments']

  events:
    'submit #new_comment': 'createCommentButton'
    'keypress textarea#comment_body': 'createCommentKeyboard'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @prependComment, this)

  render: ->
    $(@el).html(@template(cur_user: $("#comment_user_id").attr('value')))
    @collection.each(@prependComment)
    this

  prependComment: (comment) =>
    view = new CommentView(model: comment)
    @$('#commenttest').prepend(view.render().el)

  createCommentKeyboard: (e) ->
    if e.which == 13
      e.preventDefault()
      @checkCommentField()

  createCommentButton: (e) ->
    e.preventDefault()
    @checkCommentField()

  checkCommentField: ->
    if $("textarea#comment_body").val() == ''
      alert "Oops! The comment field is blank"
    else
      @createComment()

  createComment: (e) ->
    $("textarea#comment_body").attr("disabled","disabled")
    attributes =
      user_id: $('#comment_user_id').attr('value')
      league_id: $('#league_id').attr('value')
      body: $('#comment_body').val()
    @collection.create attributes,
      wait: true
      success: (model, response) ->
        $('#new_comment')[0].reset()
        $("textarea#comment_body").removeAttr("disabled")
      error: (model, response) ->
        alert "Sorry, there was an error saving the comment! Please try again later."
        $("textarea#comment_body").removeAttr("disabled")