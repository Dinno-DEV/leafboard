# Do's
- contain all categories.
- contain button name, audio file path, volume, and tags under categories.
- contain shortcut settings
- contain master volume setting
- contain dark/light mode setting
- contain accent color setting
- have getter and setter
- duplicate resources before returning them (prevent accidental save data tampering)
- handle data collection of everything. It listens to category changes, listens to new button creation, listens to button placement changes.

# Don't s
- automatically save memory to files.
- automatically put audio files to user directory.
- edit, move, or manage any kind of files.
