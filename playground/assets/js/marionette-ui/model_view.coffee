@Marionette = @Marionette || {}
@Marionette.UI = @Marionette.UI || {}
@Marionette.UI.Widgets = @Marionette.UI.Widgets || {}

class @Marionette.UI.Widgets.ModelView extends Marionette.Layout
  template: => @_genrateTemplateString(@model.toJSON())

  events:
    'click li': "replaceWithLiveInput"

  modelEvents:
    'change': 'replaceChanged'

  replaceChanged: (attrs) ->
    @render() unless @$('input').length

  replaceWithLiveInput: (e) =>
    if @options.editable
      old = $(e.currentTarget)
      if old.find('input').length is 0
        editable = new Marionette.UI.Widgets.Input
          model: @model
          attribute: old.data('attr')
          closeOnEnter: true
          liveUpdate: true

        @listenTo editable, 'close', ->
          old.replaceWith @_generateAttrItem(@model.get(old.data('attr')), old.data('attr'))

        @listenTo editable, 'blur', ->
          editable.close()

        old.html(editable.render().el)

        editable.focus()

  _generateLabel: (value)->
    "<label class='mu-capitalize'> #{if mapped = @options.attributeMap?[value] then mapped else value} </label>"

  _generateAttrItem: (attribute, value) ->
    "<li data-attr='#{value}'> #{ @_generateLabel(value) } <span class='#{ if @options.editable then "mu-editable" else "" }'> #{attribute} </span> </li>"

  _genrateTemplateString: (data) =>
    string = "<ul>"
    _.each data, (attribute, value) =>
      string += @_generateAttrItem(attribute, value)
    string +="</ul>"
    string
