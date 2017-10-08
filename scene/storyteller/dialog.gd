extends RichTextLabel

var letters_left = []
var is_writing = false

signal next()

func _ready():
	set_process_input(true)

# apis

func writeln(text):
	for l in text:
		letters_left.append(l)
	letters_left.append('\n')
	set_process(true)

func clean():
	letters_left.clear()
	set_text("")
	_flush()

func _flush():
	_delay = 0
	write_timer.emit_signal("timeout")
	
# input handling

onready var storyteller = get_node("../storyteller")
func _input(event):	
	if event.is_action_released("game_next"):
		if is_writing == true:
			_flush()
		else:
			emit_signal("next")
			
# write letter by letter
func _process(delta):
	if letters_left != '' and is_writing == false:
		is_writing = true
		_delay = delay_origin
		_write()

onready var write_timer = get_node("../timer")
onready var cursor = get_node("cursor")
var delay_origin = 0.05
var _delay = 0.05
func _write():
	while letters_left.size() != 0:
		var letter = letters_left[0]; letters_left.pop_front()
		set_text(get_text() + letter)
		if _delay != 0 and letters_left.size() != 0:
			write_timer.set_wait_time( _delay )
			write_timer.start()
			yield( write_timer, "timeout")
	is_writing = false
	#cursor.set_pos( get_cur
	
