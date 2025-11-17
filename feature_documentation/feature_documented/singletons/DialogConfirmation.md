# Do
- become a singleton
- have a function that can be called to return wether player confirm to or not confirm.
- have a queue system, it waits for one to be resolved before another.
- need their theme changed if there is a theme changer
- spawn more than one dialog confirm panel, but only activates it one at a time (depending on queue)

# How to use
- call a function with await
- function called, creates dialogue confirm panel
- await a yes or no answer from confirm panel
- return the yes or no answer from confirm panel as a function result

# functions
- request_response() - used to ask for a response. Need to use await
- focus_first_dialog() - makes only the first DialogConfirmPanel child visible.
- reveal_dialogs() - makes DialogConfirmation visible and fades in the dialog background
- hide_dialogs() - fades out the dialog background and makes DialogConfirmation invisible
