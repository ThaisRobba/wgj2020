extends Control

const entries = preload('res://Entries.gd').entries
const gen_1_young = preload('res://assets/diary/gen_1_young.png')
const gen_1_older = preload('res://assets/diary/gen_1_older.png')
const gen_2_young = preload('res://assets/diary/gen_2_young.png')
const gen_2_older = preload('res://assets/diary/gen_2_older.png')
const gen_3_young = preload('res://assets/diary/gen_3_young.png')
const gen_3_older = preload('res://assets/diary/gen_3_older.png')

const intro = """Every flower is special in its own way, 
something we can only know when they blossom. 
In their presence, 
I am just another flower in the garden. 
Me
Her
Them
Every seed a memory
Planted in this garden."""

onready var control := $Control
onready var background := $DarkBackground
onready var tween := $Tween

const offscreen_position := Vector2(960, 2160)
const onscreen_position := Vector2(960, 1080)

const dark_color := Color(0, 0, 0, 0.5)
const transparent := Color(0, 0, 0, 0)

func _ready() -> void:
	control.rect_position = offscreen_position


func close() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	$SFX/Close.play()
	tween.interpolate_property(control, "rect_position",
		onscreen_position, offscreen_position, 0.6,
		Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween.interpolate_property(background, "color",
		dark_color, transparent, 1,
		Tween.TRANS_CUBIC, Tween.EASE_IN)
	
	tween.start()


func open(day, flower) -> void:
	$Control/Text.text = get_day_entry(day, flower)
	mouse_filter = Control.MOUSE_FILTER_STOP
	$SFX/Open.play()

	tween.interpolate_property(control, "rect_position",
		offscreen_position, onscreen_position, 1,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.interpolate_property(background, "color",
		transparent, dark_color, 1,
		Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween.start()
	
	if day == 0:
		$Control/Hand.texture = gen_1_young
	elif day == 3:
		$Control/Hand.texture = gen_1_older
	elif day == 4:
		$Control/Hand.texture = gen_2_young
	elif day == 7:
		$Control/Hand.texture = gen_2_older
	elif day == 8:
		$Control/Hand.texture = gen_3_young
	elif day == 11:
		$Control/Hand.texture = gen_3_older


func _on_CloseButton_pressed() -> void:
	close()


func _on_tween_all_completed() -> void:
	if control.rect_position == offscreen_position:
		Events.emit_signal("closed_diary")


func get_day_entry(day, flower) -> String:
	if flower:
		return entries[String(flower.name) + String(day)]
	else:
		return intro
