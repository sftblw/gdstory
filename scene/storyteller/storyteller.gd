extends Control

export(String, FILE, "*.gd") var script = "res://project/script/main.gd"
var _gds = null

var is_auto = false

func _ready():
	load_script(script)
	next()

func load_script(script):
	_gds = load(script).new()
	_gds.storyteller = self

# next
var ctx = null
func next():
	if dialog.is_writing():
		dialog.flush()
	elif ctx == null:
		ctx = _gds.run()
	elif ctx != null:
		ctx = ctx.resume()

# script APIs
onready var dialog = get_node("dialog_layer/dialog")
func dialogln(text): dialog.writeln(text)
func dialogClean(): dialog.clean()