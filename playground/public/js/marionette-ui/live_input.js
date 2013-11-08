(function() {
  var _ref,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.Marionette = this.Marionette || {};

  this.Marionette.UI = this.Marionette.UI || {};

  this.Marionette.UI.Input = (function(_super) {
    __extends(Input, _super);

    function Input() {
      this.onKeyUp = __bind(this.onKeyUp, this);
      this.replaceVal = __bind(this.replaceVal, this);
      this.template = __bind(this.template, this);
      _ref = Input.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Input.prototype.template = function() {
      return _.template("<input value='<%= " + this.options.attribute + " %>' />", this.model.toJSON());
    };

    Input.prototype.ui = {
      input: 'input'
    };

    Input.prototype.modelEvents = {
      'change': 'replaceVal'
    };

    Input.prototype.events = {
      "keyup": "onKeyUp"
    };

    Input.prototype.onRender = function() {
      var _this = this;
      return this.ui.input.on('blur', function() {
        console.log('lur');
        return _this.trigger('blur');
      });
    };

    Input.prototype.replaceVal = function() {
      if (!this.$('input').is(":focus")) {
        return this.$('input').val(this.model.get(this.options.attribute));
      }
    };

    Input.prototype.onKeyUp = function(e) {
      if (e.keyCode === 13 || this.options.liveUpdate) {
        this.model.set(this.options.attribute, this.ui.input.val());
      }
      if (this.options.closeOnEnter && e.keyCode === 13) {
        return this.close();
      }
    };

    Input.prototype.focus = function() {
      return this.ui.input.focus();
    };

    return Input;

  })(Marionette.ItemView);

}).call(this);
