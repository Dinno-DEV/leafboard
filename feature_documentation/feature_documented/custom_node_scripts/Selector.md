# Do
- signals button ID when a button is selected. If the button is not an id button, ignores it.
- unselect all buttons under the node that has the same id.

# Don't
- do anything but that.

# Signals
- selected(button_id:String) - emitted when IdButton is pressed

# Functions
- set_all_button_toggle_mode()
- disable_all_non_id_button()
- unselect_all() - unselect all button
- select(id) - selects only id button
