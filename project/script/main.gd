extends "res://gdstory/basegdstory.gd"

var import = []

var script = {
	"인트로": [ # scene
		[ Opcode.dialog_ln, "환영합니다!" ], # instructions
		[ Opcode.prompt ],
		[ Opcode.dialog_ln, "gdstory는 Godot 엔진 기반의" ],
		[ Opcode.dialog_ln, "비주얼 노벨 엔진 & 프레임워크입니다." ],
		[ Opcode.prompt ],
		[ Opcode.dialog_clean ],
	],
}

var entry = "인트로"