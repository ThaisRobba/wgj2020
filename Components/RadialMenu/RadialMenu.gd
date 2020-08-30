extends Control

const menu_radius = 580 #in godot position units


func _ready() -> void:
	reset_buttons()


func reset_buttons() -> void:
	$Container.visible = false
	$Tween.stop_all()

	var buttons = get_buttons()
	
	for button in buttons:
		button.rect_position = Vector2.ZERO


func show_buttons(pos: Vector2, needs):
	reset_buttons()
	$Container.visible = true
	var buttons = get_buttons()

	if buttons.size() == 0:
		return

	var angle_offset = (2*PI)/buttons.size() #in degrees
	var angle = 0 #in radians
	
	for button in buttons: 
		button.disabled = not needs[button.name]

		var target_pos = Vector2(menu_radius, 0).rotated(angle)
		var tween = $Tween
		tween.interpolate_property(button, "rect_position",
				Vector2.ZERO, target_pos, 0.3,
				Tween.TRANS_CUBIC, Tween.EASE_IN, (angle * randf()) / 30)
		tween.start()
		angle += angle_offset
		
	$Container.rect_position = pos - $Container.rect_size /2


func get_buttons() -> Array:
	return $Container.get_children()


func _on_dialog_pressed() -> void:
	Events.emit_signal("selected_action", 'dialog')
	reset_buttons()

func _on_heal_pressed() -> void:
	Events.emit_signal("selected_action", 'heal')
	reset_buttons()


func _on_prepare_soil_pressed() -> void:
	Events.emit_signal("selected_action", 'prepare_soil')
	reset_buttons()


func _on_water_pressed() -> void:
	Events.emit_signal("selected_action", 'water')
	reset_buttons()
	

func _on_prune_pressed() -> void:
	Events.emit_signal("selected_action", 'prune')
	reset_buttons()
