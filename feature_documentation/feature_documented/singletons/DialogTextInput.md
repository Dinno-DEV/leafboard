# Do
- become a singleton
- appear on screen when called
- give out signal when text input is entered
- edit text input entry with a fucntion
- disappear from screen when called

# How to use
- call a function with await
- function called, creates dialogue text input panel
- await a yes or no answer from text input panel
- return the yes or no answer from confirm panel as a function result

# Functions
- request_response(message:String) - returns player response from the text input receiver. Need to use await.
- focus_first_dialog() - makes only the first DialogTextInputPanel child visible.
- reveal_dialogs() - makes DialogTextInput visible and fades in the dialog background
- hide_dialogs() - fades out the dialog background and makes DialogTextInput invisible
