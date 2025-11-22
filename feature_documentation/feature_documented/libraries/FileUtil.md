# Do's
- receive list of files
- has functions to filter by extension
- has functions to filter by names
- has functions to filter by size

# Functions
- is_file_name_audio_index()
- is_file_extension() - check if the file extension matches the given extension
- is_file_name_exist()
- is_audio_data_exists() - checks if the audio data already existed in the audio folder (it checks the content, not name) 
- get_audio_path_that_exists(audio_stream) - returns the file path with contents that match the audio stream.
- get_filtered_file_extension() - will return only files that has the defined extension
- get_file_name_from_path()
- get_last_audio_index() - audio file names are written by numbers. This will return highest number in the audio file, or 0 if can't find any.
- clean_file_path() - makes it so that the path uses "/" as the file directory divider thingy
- remove_extension()
- load_file_as_mp3() - AudioStreamMp3
- load_file_as_wav() - returns AudioStreamWAV
- create_settings_folder()
- create_soundboard_folder()
- create_audio_folder()
- get_directory_path() - returns directory based on the given enum. Three options, AUDIO, SETTINGS, SOUNDBOARD
