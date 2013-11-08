Marionette.UI = Marionette.UI || {}

class Marionette.UI.Button extends Marionette.ItemView
  tagName: 'button'

  events:
    'click': 'onClick'

  onClick: -> #*circkets*

  disable: -> @$el.attr 'disabled', true

  enable: -> @$el.removeAttr 'disabled'

  enabled: -> !@$el.attr('disabled')

  disabled: -> @$el.attr('disabled')

  state: -> if @disabled() then "disabled" else "enabled"
