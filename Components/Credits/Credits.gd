extends Control

const transparent := Color(0,0,0,0)
const white := Color(1,1,1,1)


func _ready() -> void:
	$TextureRect.modulate = transparent

	
func show() -> void:
	$Tween.interpolate_property($TextureRect, 'modulate', transparent, white, 3, Tween.TRANS_LINEAR)
	$Tween.start()
	
	mouse_filter = Control.MOUSE_FILTER_STOP
