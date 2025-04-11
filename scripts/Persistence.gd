extends Node

# declare lcoation for settings file and var for config
const PATH = "user://settings.cfg"
var config =  ConfigFile.new()

# set all the default aciton and event in "Controls" section in config 
func _ready():
	for action in InputMap.get_actions():
		if InputMap.action_get_events(action).size() != 0:
			config.set_value("Controls", action, InputMap.action_get_events(action)[0])
	
	config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_WINDOWED)
	config.set_value("Video", "borderless", false)
	config.set_value("Video", "vsync", DisplayServer.VSYNC_ENABLED) # give default value which will be set only for the first run
	
	# sets default values for audio
	for i in range(3):
		config.set_value("Audio", str(i), 0.0)
	
	load_data()

# writes data in a file at location PATH
func save_data():
	config.save(PATH)

# load the config...if file doesn't exist, save the default values and return
func load_data():
	if config.load("user://settings.cfg") != OK: # checks if there's a file in settings
		save_data()
		return
		
	load_control_settings() # call load_control_settings if file exists
	load_video_settings()

# get all keys from section Controls in load_controls_setting func
func load_control_settings():
	var keys = config.get_section_keys("Controls")
	
	for action in InputMap.get_actions():
		if keys.has(action):
			var value = config.get_value("Controls", action) # get every actions from config
			
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, value) # erase default and override with new value
			
# gets video data and changes the settings
func load_video_settings():
	var screen_type = config.get_value("Video", "fullscreen")
	DisplayServer.window_set_mode(screen_type)
	
	var borderless = config.get_value("Video", "borderless")
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, borderless)
	
	var vsync_index = config.get_value("Video", "vsync")
	DisplayServer.window_set_vsync_mode(vsync_index)


