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
- integrate with data collection nodes, there are several data collection nodes that will get data and report it to app memory.

# Don't s
- automatically save memory to files.
- automatically put audio files to user directory.
- edit, move, or manage any kind of files.

# Checklists
- [x] button moved data
- [x] button edited data
- [x] button volume data
- [x] button creation data
- [x] soundboard/category creation data
- [x] soundboard/category name edit data
- [x] soundboard/category delete data
- [x] previously selected soundboard/category
