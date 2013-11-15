@MU.module 'Views', (Views, App, Backbone, Marionette, $, _) ->
  class Views.Demo extends Marionette.ItemView
    template: '#page-template'
