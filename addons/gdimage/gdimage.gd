tool
extends Position2D

export(Texture) var texture setget _texture_set
func _texture_set(texture):
	__image_ensure()
	_image.set_texture(texture)

enum AnchorFrom {
	Top = 1,
	TopLeft = 2, LeftTop = 2,
	TopRight = 3, RightTop = 3,
	Bottom = 4,
	BottomLeft = 5, LeftBottom = 5,
	BottomRight = 6, RightBottom = 6,
	Left = 7,
	Right = 8,
	Center = 9
}

var _image = null
export(AnchorFrom) var anchor_from = AnchorFrom.Bottom
export(Vector2) var anchor = Vector2(0, 0) setget _anchor_set

func _ready():
	__image_ensure()

func __image_ensure():
	if not has_node("image"):
		_image = TextureRect.new()
		_image.set_name("image")
		add_child(_image)
		
		# set default pos

func _anchor_set(pos):
#	if pos == below:
#		var center_below = get_viewport().get_rect().size
#		center_below.x /= 2
#		_iamge.set_pos( center_below )
	pass
