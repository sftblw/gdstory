extends "res://gdstory/basegdstory.gd"

var import = []

var script = {
	"인트로": [ # scene
		# instructions
		[ Opcode.image_new, preload("res://" + "project/background/bg.jpg") ],
		[ Opcode.store, "동물원배경" ],

		[ Opcode._load, "동물원배경" ],
		[ Opcode.bg_new ],
		[ Opcode.store, "동물원" ],

		[ Opcode._load, "동물원" ],
		[ Opcode.bg_show ],

		[ Opcode.chara_new ],
		[ Opcode.store, "미래" ],

		[ Opcode._load, "미래" ],
		[ Opcode.image_new, preload("res://project/standing/mirae_normal.png") ],
		[ Opcode.chara_face, "normal" ],

		[ Opcode._load, "미래" ],
		[ Opcode.chara_show, "normal"],

		[ Opcode.dialog_ln, "환영합니다!" ], 
		[ Opcode.prompt ],
		[ Opcode.dialog_ln, "gdstory는 Godot 엔진 기반의" ],
		[ Opcode.dialog, "비주얼 노벨 엔진 & 프레임워크입니다." ],
		[ Opcode.prompt ],
		[ Opcode.dialog_clean ],
	],
}

var entry = "인트로"