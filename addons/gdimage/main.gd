tool
extends EditorPlugin

const nodeName_GDImage = "GDImage"

func _enter_tree():
	add_custom_type(nodeName_GDImage, "Position2D", preload("./gdimage.gd"), preload("./gdimage.png"))

func _exit_tree():
	remove_custom_type(nodeName_GDImage)