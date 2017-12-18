extends "res://gdstory/gdstoryscript.gd"

func run():
#	b1() # 인트로
#
#func b1(): # 인트로
#	img["bg"].color = "black"
#	chara.new("미래")
#	chara["미래"].color = "black"
#	chara["미래"].img["미소"] = preload("res://img/mirae_smile.png")

#	dialog.name(chara["미래"].name)
	dialogln("환영합니다!")
	yield(); dialogln("gdstory는 Godot 엔진 기반의")
	dialogln("비주얼 노벨 엔진 & 프레임워크입니다.")
	
	yield(); dialogClean()
	
#	dialog.ln("보고싶은 내용을 선택해주세요.")

	return null