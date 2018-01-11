tool
extends Control

export(String, MULTILINE) var text = "B.om"
export(DynamicFont) var dynamic_font = null
export(int) var default_font_size = 10
export(PackedScene) var letter_scene = null

var letters_left = []
var is_writing = false setget , is_writing
func is_writing(): return is_writing

export(float) var delay_origin = 0.05
var write_timer = null
var _delay = 0.05

func _ready():
	if not has_node("timer"):
		write_timer = Timer.new()
		write_timer.set_name("timer")
		add_child(write_timer)
	
	# initial text
	if text.length() > 0:
		write(text)

	if not Engine.is_editor_hint():
		__clear()
		set_process(true)
	else:
		flush()

# write string (API)
func write(text):
	for l in text:
		letters_left.append(l)
	set_process(true)
	
# write one line of string (API)
func writeln(text):
	for l in text:
		letters_left.append(l)
	letters_left.append('\n')
	set_process(true)

# remove all text (API)
func clean():
	letters_left.clear()
	cursor_pos = Vector2(0, 0)
	col_row = Vector2(0, 0)
	flush()
	__clear()

# emit all left text instantly (API)
func flush():
	_delay = 0
	write_timer.emit_signal("timeout")
	
# write letter by letter
func _process(delta):
	if letters_left.size() > 0 and is_writing == false:
		is_writing = true
		_delay = delay_origin
		__render()

# render letters
var cursor_pos = Vector2(0, 0)
var col_row = Vector2(0, 0)
func __render():
	dynamic_font.set_size(default_font_size)
	
	var last_max_height = dynamic_font.get_string_size(" ").y + dynamic_font.get_spacing( DynamicFont.SPACING_TOP )
	
	# for each letter
	while letters_left.size() != 0:
		var letter = letters_left[0]; letters_left.pop_front()
		
		# get current letter size
		var letter_size = dynamic_font.get_string_size(letter)
		
		# pause when output can overflow
		if cursor_pos.y + letter_size.y > get_size().y: return
		
		# set cursor to next line when (\n or overflow)
		if letter == "\n\r" or letter == "\n" \
			or cursor_pos.x + letter_size.x >= get_size().x: # get_size().x is width
			
			if cursor_pos.x + letter_size.x >= get_size().x: # get_size().x is width
				letters_left.push_front(letter)
			
			col_row.y += 1; col_row.x = 0
			cursor_pos.y += last_max_height + dynamic_font.get_spacing( DynamicFont.SPACING_TOP ) + dynamic_font.get_spacing( DynamicFont.SPACING_BOTTOM )
			cursor_pos.x = 0

			continue
		
		# calculate spacing when It's space
		elif letter == " ":
			cursor_pos.x += letter_size.x + dynamic_font.get_spacing( DynamicFont.SPACING_SPACE )
			continue
		
		# create letter by label
		var label = null
		var container = Control.new()
		if letter_scene == null or Engine.is_editor_hint():
			label = Label.new()
		else:
			label = letter_scene.instance()
		
		label.add_font_override( "font", dynamic_font.duplicate( false ) )
		label.set_text(letter)
		container.rect_position = cursor_pos
		label.set_size(letter_size)
		container.set_size(letter_size)
		
		container.add_child(label)
		add_child(container)
		
		# calculate new cursor_pos
		cursor_pos.x += letter_size.x + dynamic_font.get_spacing( DynamicFont.SPACING_CHAR )
		if last_max_height < letter_size.y:
			cursor_pos.y += letter_size.y - last_max_height
			last_max_height = letter_size.y
		
		# test purpose
#		dynamic_font.set_size( dynamic_font.get_size() + 1 )
		#dynamic_font.set_size( 15 + randi() % 10 )
		
		# wait before write next letter  # and not on editor
		if _delay != 0 and letters_left.size() != 0 and not Engine.is_editor_hint():
			write_timer.set_wait_time( _delay )
			write_timer.start()
			yield( write_timer, "timeout")
	is_writing = false
	set_process(false)

# in editor, draw all letters instantly
func _draw():
	# for editor
	if Engine.is_editor_hint():
		clean()
		if text.length() > 0:
			write(text)
		_delay = 0
		__render()

# free all children
func __clear():
	for child in get_children():
		if not child is Timer:
			child.queue_free()