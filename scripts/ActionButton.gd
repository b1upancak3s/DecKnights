extends Button

@export var action : String = "ui_up"

func _ready():
	set_process_unhandled_key_input(false)
	display_key()
	
#func to assign text from InputMap Event
func display_key():
	text = InputMap.action_get_events(action)[0].as_text()
	
func remap_action_to(event):
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, event)
	
	Persistence.config.set_value("Controls", action, event)
	Persistence.save_data()
	
	text = event.as_text() # updates the text

# turn on key process, change text
func _on_pressed():
	set_process_unhandled_key_input(true)
	text = "Press any key"
	
# for unhandled key, rempa to new event, set key process to false, and release the key
func _unhandled_key_input(event):
	remap_action_to(event)
	set_process_unhandled_key_input(false)
	release_focus()
