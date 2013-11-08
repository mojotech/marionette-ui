(function() {
  console.log("hello from a require'd coffee file (via assets/js/_helper.coffee)");

}).call(this);

(function() {
  this.MU = (function(Backbone, Marionette) {
    var App;
    console.log('foo');
    App = new Marionette.Application();
    App.addRegions({
      modelView: ".model-view",
      editableModelView: ".editable-model-view",
      liveInput: ".live-input"
    });
    App.addInitializer(function() {
      return App.currentUser = new Backbone.Model({
        name: "Aaron Snyder",
        age: 23,
        hometown: "Old Saybrook, CT",
        current_town: "Providence, RI"
      });
    });
    App.on("initialize:after", function() {
      App.modelView.show(new Marionette.UI.ModelView({
        model: App.currentUser
      }));
      App.editableModelView.show(new Marionette.UI.ModelView({
        model: App.currentUser,
        editable: true
      }));
      return App.liveInput.show(new Marionette.UI.Input({
        model: App.currentUser,
        attribute: 'hometown',
        liveUpdate: true
      }));
    });
    return App;
  })(Backbone, Marionette);

  $(function() {
    return MU.start();
  });

}).call(this);
