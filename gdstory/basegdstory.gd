extends GDScript

enum Opcode {
	invalid = 0,
	nop,
	prompt, # wait user input
	dialog,
	dialog_ln,
	dialog_clean,
	gdscript,
	scene
}