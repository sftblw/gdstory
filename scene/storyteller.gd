extends Control

export(String, FILE, "*.gd") var script = "res://project/script/main.gd"
var _gds = null

func _ready():
	load_script()
	execute()

func load_script():
	_gds = load(script).new()
	_gds.storyteller = self

var ctx = null
func execute():
	if ctx == null:
		ctx = _gds.run()
	elif ctx != null:
		ctx = ctx.resume()

onready var dialog = get_node("dialog")
func dialogln(text): dialog.writeln(text)
func dialogClean(): dialog.clean()