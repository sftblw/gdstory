; 주석
비가 오는 날이었다.             ; dialogln("비가 오는 날이었다."); yield()
맑은 하늘이었으면 좋았으련만.    ; dialogln("맑은 하늘이었으면 좋았으련만."); yield()
; dialogClean()
; (ignore here)
하필이면 내가 미끄러졌을 때 내 눈 앞에 그녀가 있었고, ; dialogln("하필이면 내가 미끄러졌을 때 내 눈 앞에 그녀가 있었고,")
_뒤에 일어난 일은 내 기분을 비참하게 만들었다.       ; dialogln("뒤에 일어난 일은 내 기분을 처참하게 만들었다."); yield()

<"bg/road.png"> ; bgImg("res://project/bg/road.png"); preload("res://project/bg/road.png") ; preload 처리가 될까...?

@미예 ; chara("미예"); ; define first
@미예 image="standing/miye.png" ; charaImg("미예", "res://project/standing/miye.png")
@미예 nameplate="부딪힌 사람"    ; charaNameplate("미예", "부딪힌 사람")

[미예] ; showChara("미예"); (showChara 안에 nameplate("부딪힌 사람") 있음)
저기... 괜찮으신가요?            ; dialogln("뒤에 일어난 일은 내 기분을 처참하게 만들었다."); yield()

@진우 image="standing/jinwoo.png" ; chara("진우"); charaImg("진우", "res://project/standing/jinwoo.png")
@ nameplate="나"; charaNameplate("진우", "나")
[진우] ; showChara("진우")
괜찮... 습니다._ 아마도요? -\_-\;\; ; dialog("괜찮... 습니다."); yield(); dialogln("아마도요? -_-;;"); yield()

[!진우] ; exitChara("진우")
[!미예] ; exitChara("미예")
아아... 아마도요라니, 나 대체 무슨 말을 한 거지. ; dialogln("뒤에 일어난 일은 내 기분을 처참하게 만들었다."); yield()

<"bg/sunlight.png" fadein(1)>
밝은 햇살을 이기며 손을 붙잡고 일어섰다.

; TODO: GDScript 그대로 실행하는 구문