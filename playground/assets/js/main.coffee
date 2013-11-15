@MU = do (Backbone, Marionette) ->
  App = new Marionette.Application()
  App.addRegions
    page: '#page'

  App.addInitializer ->
    App.currentUser = new Backbone.Model
      name: "Aaron Snyder"
      age: 23
      hometown: "Old Saybrook, CT"
      current_town: "Providence, RI"

  App.on "initialize:after", ->
    App.page.show new App.Views.Demo
      model: App.currentUser

  App

$ ->
  MU.start()
