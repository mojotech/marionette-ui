do (Marionette) ->
  Marionette.UI ?= {}
  Marionette.UI.Widgets ?= {}

  class Marionette.UI.WidgetManager extends Marionette.RegionManager
    initialize: (options={}) ->
      {@view, @widgets} = options
      _.each @widgets, (definition, name, widgets) -> widgets[name].selector ?= ".#{name}"
      @_initializeWidgets()

    _initializeWidgets: ->
      return unless @widgets?

      defaults =
        parentEl: => @view.$el

      @addRegions @widgets, defaults

    _ensureSelectorElement: (widgetName, selector) ->
      unless @view.$(selector).length > 0
        @view.$el.append $('<div />', class: widgetName)

    showWidgets: =>
      {model, collection} = @view

      _.each @widgets, (definition, name) =>
        options = _.extend {}, {model, collection}, definition

        widgetView = new Marionette.UI.Widgets[definition.widget](options)

        @_ensureSelectorElement name, definition.selector

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
