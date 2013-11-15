*Working Understanding*
By including marionette-ui all we protypically extend Marionette.View to support widgets.
On any view you should be able to define a widgets hash as follows:

widgets:
  sumbitButton:
    selector: '.submit'
    type: "Button"

Where selector is css selector that is present in your view's template. And type is the widget type. By default
the widget will use the current view's model/collection. If the current view is a composite view it will use the model
unless specified.

When a view is rendered, if it has widgets all widgets will be shown in that view's onShow method.
Widgets can then be accessed similar to the ui hash as follows:

@widgets.submitButton.disable()


*Marionette.UI.Button*
The button widget can take either a hardcoded content string or a contentAttribute. A content attribute will bind the display text of the button to that attribute of the model. If the model's attribute changes, the display will be updated accordingly. If you do not want the display text to be a property of the model, no problem just set the content attribute to a string. If both content and contentAttribute are filled in, content will take priority.

widgets:
  sumbitButton:
    selector: '.submit'
    type: "Button"
    content: "A hardcoded string"
    contentAttribute: 'name'

Public methods:
  disable: Enable the button
  disable: Disable the button
  onClick: fired when the button is clicked
  state: returns either Enabled or Disabled
  enabled: returns true if the button is enabled

Widget Manager


Widgets
  Button
  Segmented Control
  Modal

