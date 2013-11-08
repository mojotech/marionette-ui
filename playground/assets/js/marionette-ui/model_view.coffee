@Marionette = @Marionette || {}
@Marionette.UI = @Marionette.UI || {}

class @Marionette.UI.ModelView extends Marionette.Layout

  modelEvents:
    'change': 'replaceChanged'

  replaceChanged: (attrs) ->
    console.log attrs
    @render() unless @$('input').length

  events:
    'click li': "replaceWithLiveInput"

  replaceWithLiveInput: (e) =>
    if @options.editable
      old = $(e.currentTarget)
      if old.find('input').length is 0
        editable = new Marionette.UI.Input
          model: @model
          attribute: old.data('attr')
          closeOnEnter: true
          liveUpdate: true

        @listenTo editable, 'close', ->
          old.html(@model.get(old.data('attr')))

        @listenTo editable, 'blur', ->
          editable.close()

        old.html(editable.render().el)

        editable.focus()

  template: => @_genrateTemplateString(@model.toJSON())

  _genrateTemplateString: (data) ->
    string = "<ul>"
    _.each data, (attribute, value) ->
      string += "<li data-attr='#{value}' > #{attribute} </li>"
    string +="</ul>"
    string

  # initialize: ->
  #   if @options.editable


  # toCollection: ->
  #   _.map @model.toJSON(), (key, value) ->
  #     attribute: key, value: value
