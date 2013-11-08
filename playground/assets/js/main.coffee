#= require "_helper"

@MU = do (Backbone, Marionette) ->
  console.log 'foo'
  App = new Marionette.Application()
  App.addRegions
    modelView: ".model-view"
    editableModelView: ".editable-model-view"

    liveInput: ".live-input"

  App.addInitializer ->
    App.currentUser = new Backbone.Model
      name: "Aaron Snyder"
      age: 23
      hometown: "Old Saybrook, CT"
      current_town: "Providence, RI"

  App.on "initialize:after", ->
    App.modelView.show new Marionette.UI.ModelView
      model: App.currentUser

    App.editableModelView.show new Marionette.UI.ModelView
      model: App.currentUser
      editable: true

    App.liveInput.show new Marionette.UI.Input
      model: App.currentUser
      attribute: 'hometown'
      liveUpdate: true

  App

$ ->
  MU.start()
