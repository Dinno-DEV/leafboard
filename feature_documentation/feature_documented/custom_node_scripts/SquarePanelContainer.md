# Do
- makes it so that the sizes always sync with each other, forming a square.

# Variables
- is_following_width - if true, the height follows width. Opposite if false.
- flow_container_uniform - if true, it will attempt to make all sizes uniform in flow container. It only works inside flow container that has SquarePanelContainer as all its children.

# Functions
- get_parent_flow_row() -> int - returns the division of the FlowContainer's children. This is the opposite line of get_line_count() in FlowContainer.
- is_all_sibling_square_panel() -> bool
- get_total_panel_width() -> float - width of all panel + separation
- get_total_panel_height() -> float - height of all panel + separation
