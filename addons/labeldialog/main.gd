tool
extends EditorPlugin

const nodeName_LabelDialog = "LabelDialog"

func _enter_tree():
	add_custom_type(nodeName_LabelDialog, "Control", preload("./labeldialog.gd"), preload("./labeldialog.png"))

func _exit_tree():
	remove_custom_type(nodeName_LabelDialog)