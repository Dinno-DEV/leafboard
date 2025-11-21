# Do
- use to contain "SoundboardButtons" scenes.
- use as an interface to change sound board button size
- use as an overall soundboard button info getter, such as name, now playing(s), volume, tag information
- use as soundboard button manager (making it visible or invisible)
- use to add new soundboard button
- able to delete soundboard button
- use to get list of soundboard buttons in the soundboard.
- listen to category changes broadcaster to change its soundboard name.

# Don't
- use as category switcher. Category switcher is another thing.
- use as a saver or modifier for app memory
- use it as a searcher

# Functions
- add_new_button()
- delete_button()
- get_soundboard_name()
- get_all_button_id()
- get_button_volume()
- get_button_tags()
- get_now_playing()
- get_button_by_id()
- set_soudboard_name()
- set_button_visible()
- set_button_invisible()
- set_all_buttons_visible()
- set_all_buttons_invisible()
- set_all_buttons_size
