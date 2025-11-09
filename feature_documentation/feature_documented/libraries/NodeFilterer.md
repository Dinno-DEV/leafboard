# Do
- filter node based on name
- filter node based on type

# Static Functions
- by_name_beginning(nodes:Array[Node], node_name:String) -> Array - returns all node with beginning "node_name".
- by_name_ending(nodes:Array[Node], node_name:String) -> Array - returns all node with ending "node_name".
- by_name(nodes:Array[Node], node_name:String) -> Node - returns a node that exactly matches the "name".
- by_type(nodes:Array[Node], type:String) -> Array - returns all node with type "type". If an object has custom script, the type of the custom script will be checked.
