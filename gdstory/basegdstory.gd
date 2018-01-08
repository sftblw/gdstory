extends GDScript

enum Opcode {
	invalid = 0,  # breakpoint
	nop,          # # () -> () # does nothing
	prompt,       # # () -> () # wait untill user input
	dialog,       # string # () -> () # dialog string
	dialog_ln,    # string # () -> () # dialog string
	dialog_clean, # string # () -> () # clean dialog
	_load, # "var name" # (         ) -> (any value)
	store, # "var name" # (any value) -> (         )
	pop,
	image_new, # preload() # (          ) -> (type image)
	bg_new,    #           # (type image) -> (type bg   )
	bg_show,   #           # (type bg   ) -> ()
	chara_new, #           # (          ) -> (type chara)
	chara_face,# string    # (type chara, type image) -> ()
	chara_show,
	gdscript,
}