@MU.module 'Views', (Views, App, Backbone, Marionette, $, _) ->
  class Views.Demo extends Marionette.ItemView
    template: '#page-template'

    widgets:
      liveInput:
        selector: '.live-input'
        widget: 'Input'
        attribute: 'hometown'
        liveUpdate: true

      modelView:
        selector: ".model-view"
        widget: 'ModelView'

      editableModelView:
        selector: ".editable-model-view"
        widget: 'ModelView'
        editable: true
        attributeMap:
          'current_town': 'Current Town'
