extends Control

export(String, FILE, "*.gd") var main_script = "res://project/script/main.gd"

var is_auto = false

signal script_loaded

func _ready():
	load_script(main_script)
	emit_signal("script_loaded")
	next()

func load_script(script):
	var scr = load(script).new()
	# load data
	for scene_name in scr.script:
		if not _script.has(scene_name):
			_script[scene_name] = scr.script[scene_name]
		else:
			printerr("scene %s already loaded in script %s" % [scene_name, script], script)
	
	# load more script
	for script_path in scr.import:
		load_script(script_path)
	
	if scr.entry != null:
		if _cur_scene == null:
			if _script[scr.entry] != null:
				_cur_scene = _script[scr.entry]
				_cur_scene_name = scr.entry
			else: printerr("entrypoint %s was mentioned but scene %s does not exist." % [ scr.entry, scr.entry ])
		else: printerr("entrypoint %s was initialized more than twice!" % scr.entry)	

# interpreter
var Opcode = preload("res://gdstory/basegdstory.gd").Opcode #enum
var _script = {}
var _var = {} #variables of interpreter native code
var _stack = []
func _stack_pop():
	if _stack.size() <= 0:
		print("stack is empty but tries to get value!")
		breakpoint
	var pop_val = _stack[_stack.size() - 1]
	_stack.pop_back()
	return pop_val
var _cur_scene = null
var _cur_scene_name = null # additional variable for debugging
var _pc = 0
func _interpret():
	while _cur_scene != null and _cur_scene.size() > _pc:
		# TODO: switch (when it is implemented)
		var instruction = _cur_scene[_pc]
		var opcode = instruction[0]
		
		if opcode == Opcode.invalid:
			# TODO: print to debugger (when it is implemented)
			print("Opcode.invalid: scene %s pc %d" % [ _cur_scene_name, _pc ])
			breakpoint
		elif opcode == Opcode.nop:    pass
		elif opcode == Opcode.prompt:       yield()
		elif opcode == Opcode.dialog:       dialog      (instruction[1])
		elif opcode == Opcode.dialog_ln:    dialog_ln   (instruction[1])
		elif opcode == Opcode.dialog_clean: dialog_clean()
		elif opcode == Opcode._load:
			if _var.has(instruction[1]):
				_stack.push_back(_var[instruction[1]])
			else:
				print("no such variable! : %s" % instruction[1])
				breakpoint
		elif opcode == Opcode.store:
			_var[instruction[1]] = _stack_pop()
		elif opcode == Opcode.pop:
			_stack_pop()
		elif opcode == Opcode.image_new:
			var image = TextureFrame.new()
			image.set_texture( instruction[1] )
			image.hide()
			_stack.push_back(image)
		elif opcode == Opcode.bg_new:
			var bg = Control.new()
			bg.set_size( get_viewport().get_rect().size )
			
			bg.set_anchor_and_margin( MARGIN_LEFT, ANCHOR_BEGIN, 0 )
			bg.set_anchor_and_margin( MARGIN_TOP, ANCHOR_BEGIN, 0 )
			bg.set_anchor_and_margin( MARGIN_RIGHT, ANCHOR_END, 0 )
			bg.set_anchor_and_margin( MARGIN_BOTTOM, ANCHOR_END, 0 )
			
			var image = _stack_pop()
			
			image.set_expand( true )
			image.set_stretch_mode( TextureFrame.STRETCH_KEEP_ASPECT_COVERED )
			image.set_size( get_viewport().get_rect().size )
			
			image.set_anchor_and_margin( MARGIN_LEFT, ANCHOR_BEGIN, 0 )
			image.set_anchor_and_margin( MARGIN_TOP, ANCHOR_BEGIN, 0 )
			image.set_anchor_and_margin( MARGIN_RIGHT, ANCHOR_END, 0 )
			image.set_anchor_and_margin( MARGIN_BOTTOM, ANCHOR_END, 0 )
			
			bg.add_child(image)
			
			get_node("bg_layer").add_child(bg)
			
			_stack.push_back(bg)
		elif opcode == Opcode.bg_show:
			var bg = _stack_pop()
			
			for image in bg.get_children():
				image.show()
		elif opcode == Opcode.chara_new:
			var chara = Control.new()
			var center_below = get_viewport().get_rect().size
			center_below.x /= 2
			
			chara.set_pos( center_below )
			get_node("chara_layer").add_child(chara)
			
			_stack.push_back(chara)
		elif opcode == Opcode.chara_face:
			var face_image = _stack_pop()
			var chara = _stack_pop()
			
			face_image.set_name(instruction[1])
			chara.add_child(face_image)
			
			var face_image_size = face_image.get_size()
			face_image.set_pos(Vector2(-face_image_size.x/2, -face_image_size.y))
		elif opcode == Opcode.chara_show:
			var chara = _stack_pop()
			
			chara.get_node(instruction[1]).show()
		else:
			print("Uncovered opcode: %s" % opcode) # TODO: make printable as string
			breakpoint
			
		
		_pc += 1
		
	if _cur_scene.size() <= _pc:
		# TODO: print to debugger (when it is implemented)
		print("No more opcode at scene %s: pc is %d" % [_cur_scene_name, _pc])
		breakpoint
		
	return null

# flush and next
var _ctx = null
func next():
	if dialog.is_writing():
		dialog.flush()
	elif _ctx == null:
		_ctx = _interpret()
	elif _ctx != null:
		_ctx = _ctx.resume()

# script APIs
onready var dialog = get_node("dialog_layer/dialog")
func dialog(text)   : dialog.write(text)
func dialog_ln(text): dialog.writeln(text)
func dialog_clean() : dialog.clean()