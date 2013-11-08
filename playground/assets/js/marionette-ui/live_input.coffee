@Marionette = @Marionette || {}
@Marionette.UI = @Marionette.UI || {}

class @Marionette.UI.Input extends Marionette.ItemView

  template: => _.template("<input value='<%= #{ @options.attribute } %>' />", @model.toJSON())

  ui:
    input: 'input'


  modelEvents:
    'change': 'replaceVal'

  events:
    "keyup": "onKeyUp"

  onRender: ->
    @ui.input.on 'blur', =>
      console.log 'lur'
      @trigger 'blur'

  replaceVal: =>
    unless @$('input').is(":focus")
      @$('input').val @model.get(@options.attribute)

  onKeyUp: (e) =>
    if e.keyCode is 13 or @options.liveUpdate
      @model.set @options.attribute, @ui.input.val()
    if @options.closeOnEnter and e.keyCode is 13
      @close()

  focus: ->
    @ui.input.focus()
