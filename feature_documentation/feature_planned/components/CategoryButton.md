# Do
- contain delete button, category name, and edit button
- call dialogue confirm upon pressing delete button, selects previous category button. If there is none, it creates a dummy first, selects it, and then deletes itself afterwards.
- calls text input dialog upon pressing edit button, waits for the response, if canceled do nothing. If confirmed change the category name of itself, and then calls the category change broadcaster to announce that a category is changed.

# Do not
- change the category title
- change the category node name on the soundboard content switcher.
