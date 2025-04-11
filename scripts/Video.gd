extends TabBar

func _ready():
	# gets screen type value and sets the button accordingly
	var screen_type = Persistence.config.get_value("Video", "fullscreen")
	if screen_type == DisplayServer.WINDOW_MODE_FULLSCREEN:
		%FullScreen.button_pressed = true
		
	var borderless_type = Persistence.config.get_value("Video", "borderless")
	if borderless_type == true:
		%Borderless.button_pressed = true
		
	var vsync_index = Persistence.config.get_value("Video", "vsync")
	%VSync.selected = vsync_index

# changes fullscreen settings based on the check box
func _on_full_screen_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Persistence.config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Persistence.config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_WINDOWED)
		
	Persistence.save_data() # sets and saves the fullscreen



func _on_borderless_toggled(toggled_on):
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggled_on)
	Persistence.config.set_value("Video", "borderless", toggled_on)
	Persistence.save_data() # set and saves borderless setting

func _on_v_sync_item_selected(index):
	DisplayServer.window_set_vsync_mode(index)
	Persistence.config.set_value("Video", "vsync", index)
	Persistence.save_data() # sets and saves the vsync value
