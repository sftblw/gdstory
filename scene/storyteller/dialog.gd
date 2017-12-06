extends RichTextLabel

var letters_left = []
var is_writing = false setget , is_writing
func is_writing(): return is_writing

func _ready():
	pass

## apis

# write one line of string
func writeln(text):
	for l in text:
		letters_left.append(l)
	letters_left.append('\n')
	set_process(true)

# remove all text
func clean():
	letters_left.clear()
	clear()
	flush()

# emit all left text instantly
func flush():
	_delay = 0
	write_timer.emit_signal("timeout")
	
# write letter by letter
func _process(delta):
	if letters_left != '' and is_writing == false:
		is_writing = true
		_delay = delay_origin
		_write()

onready var write_timer = get_node("timer")
onready var cursor = get_node("cursor")
var delay_origin = 0.05
var _delay = 0.05

# write all letter by letter from letters_left
func _write():
	while letters_left.size() != 0:
		var letter = letters_left[0]; letters_left.pop_front()
		add_text(letter)
		if _delay != 0 and letters_left.size() != 0:
			write_timer.set_wait_time( _delay )
			write_timer.start()
			yield( write_timer, "timeout")
	is_writing = false
	#cursor.set_pos( get_cur
	
