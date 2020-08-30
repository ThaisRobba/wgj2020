extends Control

const offscreen_position = Vector2(0, -720)
const onscreen_position = Vector2(0, 0)

const dark_color := Color(0, 0, 0, 0.7)
const transparent := Color(0, 0, 0, 0)

onready var background = $Background
onready var titleTexture = $Control

var is_animating = false

func _ready() -> void:
	background.color = dark_color


func _on_Title_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and not is_animating:
		is_animating = true
		var tween = $Tween
		tween.interpolate_property(titleTexture, 'rect_position',
			onscreen_position, offscreen_position, 1,
			Tween.TRANS_BACK, Tween.EASE_IN, 0.2)
		tween.interpolate_property(background, "color",
			dark_color, transparent, 1,
			Tween.TRANS_CUBIC, Tween.EASE_IN, 0.5)
		tween.start()


func _on_Tween_tween_all_completed() -> void:
	Events.emit_signal("finished_showing_title")
	queue_free()

