extends "res://gdstory/gdstoryscript.gd"

func run():
	dialogln("비가 오는 날이었다."); yield()
	dialogln("맑은 하늘이었으면 좋았으련만."); yield()
	dialogClean()
	
	dialogln("하필이면 내가 미끄러졌을 때 내 눈 앞에는 그녀가 있었고,")
	dialogln("뒤에 일어난 일은 내 기분을 처참하게 만들었다."); yield()
	dialogClean()
	
	chara("미예");
	charaImg("미예", "res://project/standing/miye.png")
	charaNameplate("미예, 부딪힌 사람")
	
	return null