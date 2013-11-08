(function() {
  var _ref,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.Marionette = this.Marionette || {};

  this.Marionette.UI = this.Marionette.UI || {};

  this.Marionette.UI.ModelView = (function(_super) {
    __extends(ModelView, _super);

    function ModelView() {
      this.template = __bind(this.template, this);
      this.replaceWithLiveInput = __bind(this.replaceWithLiveInput, this);
      _ref = ModelView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    ModelView.prototype.modelEvents = {
      'change': 'replaceChanged'
    };

    ModelView.prototype.replaceChanged = function(attrs) {
      console.log(attrs);
      if (!this.$('input').length) {
        return this.render();
      }
    };

    ModelView.prototype.events = {
      'click li': "replaceWithLiveInput"
    };

    ModelView.prototype.replaceWithLiveInput = function(e) {
      var editable, old;
      if (this.options.editable) {
        old = $(e.currentTarget);
        if (old.find('input').length === 0) {
          editable = new Marionette.UI.Input({
            model: this.model,
            attribute: old.data('attr'),
            closeOnEnter: true,
            liveUpdate: true
          });
          this.listenTo(editable, 'close', function() {
            return old.html(this.model.get(old.data('attr')));
          });
          this.listenTo(editable, 'blur', function() {
            return editable.close();
          });
          old.html(editable.render().el);
          return editable.focus();
        }
      }
    };

    ModelView.prototype.template = function() {
      return this._genrateTemplateString(this.model.toJSON());
    };

    ModelView.prototype._genrateTemplateString = function(data) {
      var string;
      string = "<ul>";
      _.each(data, function(attribute, value) {
        return string += "<li data-attr='" + value + "' > " + attribute + " </li>";
      });
      string += "</ul>";
      return string;
    };

    return ModelView;

  })(Marionette.Layout);

}).call(this);
