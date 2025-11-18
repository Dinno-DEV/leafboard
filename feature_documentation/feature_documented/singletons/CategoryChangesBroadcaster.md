# Do
- have a function to announce category name changes
- signals when a category name is changed

# Do not
- change any category related stuff, including the memory or display.

#signal
- category_name_changed(previous_name:String, new_name:String)
- category_deleted(category_name:String)
- category_repositioned(category_name:String, new_position:int)
- category_added(category_name:String)

# functions
- announce_name_change
- announce_deleted
- announce_repositioned
- announce_new_category
