extends Control

func _ready():
	set_process_input(true)

signal next()
signal backlog()
signal toggle_auto()

# input handling
func _input(event):
	if event.is_action_released("game_next"):
		emit_signal("next")