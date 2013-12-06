do (Marionette) ->
  Marionette.UI ?= {}
  Marionette.UI.Widgets ?= {}

  class Marionette.UI.WidgetManager extends Marionette.RegionManager
    widgetContainer: '.mu-widget-container'

    initialize: (options={}) ->
      {@view, @widgets} = options
      _.each @widgets, (definition, name, widgets) -> widgets[name].selector ?= ".#{name}"
      @view.widgets = {}
      @_initializeWidgets()

    _initializeWidgets: ->
      return unless @widgets?

      defaults =
        parentEl: => @view.$el

      @addRegions @widgets, defaults

    _ensureSelectorElement: (name, definition) ->
      unless @view.$(definition.selector).length > 0
        widgetRegion = $('<div />', class: name)
        if (container = @view.$(@widgetContainer)).length > 0
          container.append widgetRegion
        else
          @view.$el.append widgetRegion

    showWidgets: =>
      {model, collection} = @view

      _.each @widgets, (definition, name) =>
        options = _.extend {}, {model, collection}, definition

        widgetView = new Marionette.UI.Widgets[definition.widget](options)

        @_ensureSelectorElement name, definition

        @get(name).show widgetView
        @view.widgets[name] = widgetView

  originalConstructor = Marionette.View::constructor
  Marionette.View::constructor = ->
    args = Array::slice.apply(arguments)
    originalConstructor.apply this, args

    if (widgets = Marionette.getOption(this, 'widgets'))
      @_widgetManager = new Marionette.UI.WidgetManager
        view: this
        widgets: widgets
      @listenTo this, 'show', @_widgetManager.showWidgets
