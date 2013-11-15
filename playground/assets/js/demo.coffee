@MU.module 'Views', (Views, App, Backbone, Marionette, $, _) ->
  class Views.Demo extends Marionette.ItemView
    template: '#page-template'

    widgets:
      liveInput:
        selector: '.live-input'
        widget: 'Input'
        attribute: 'hometown'
        liveUpdate: true
