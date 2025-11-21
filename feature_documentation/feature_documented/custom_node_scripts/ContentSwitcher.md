# Do
- contains reference and listens to selector class
- enable/disable visibility of child node based on the id/name from selector
- does not do anything if the content switcher cannot find the name of child corresponding to the id/name from selector

# Reference Node Variables
- selector:Selector

# Functions
- hide_all_content() - makes all Control type nodes invisible.
- show_first_content() - shows the first Control node under the ContentSwitcher.
- show_content(id:String) - Control node with 'id' as the name becomes visible, while the rest is turned invisible.
- get_selected_node() - returns currently visible node
