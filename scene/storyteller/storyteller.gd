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