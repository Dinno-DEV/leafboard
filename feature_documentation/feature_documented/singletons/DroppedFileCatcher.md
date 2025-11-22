# Do's
- Detect if mouse has any file inside of it or not
- Detect if any file is dropped on a position
- Signals files when mouse is in window
- Signals mouse position everytime a mouse with file is in window.
- Signals files and mouse position when mouse dropped files in window.

# Don't s
- Filter file based on extensions
- Filter file based on names
- Spawn audio buttons into soundboard

# Signals
- files_dropped(file_paths:Array[String]) - emitted when file(s) are dropped. It only emits if the files are .mp3 or .wav.
