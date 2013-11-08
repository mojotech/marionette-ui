do (Marionette) ->
  Marionette.UI ?= {}
  Marionette.UI.Widgets ?= {}

  class Marionette.UI.WidgetManager extends Marionette.RegionManager
    initialize: (options={}) ->
      @view = options.view
      @widgets = options.widgets
      @_initializeWidgets()

    _initializeWidgets: ->
      return unless @widgets?

      defaults =
        parentEl: => @view.$el

      @addRegions @widgets, defaults

    showWidgets: =>
      {model, collection} = @view

      _.each @widgets, (definition, name) =>
        widgetView = new Marionette.UI.Widgets[definition.widget] {model, collection}
        @get(name).show widgetView

  originalConstructor = Marionette.View::constructor
  Marionette.View::constructor = ->
    args = Array::slice.apply(arguments)
    originalConstructor.apply this, args

    if (widgets = Marionette.getOption(this, 'widgets'))
      @_widgetManager = new Marionette.UI.WidgetManager
        view: this
        widgets: widgets
      @listenTo this, 'show', @_widgetManager.showWidgets
