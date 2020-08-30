extends Node2D

const entries = preload('res://Entries.gd').entries

var current_day := -1
var current_flower : Plant
var first_flower_of_day: Plant

const SFXS = {
	water = 0,
	dialog = 1,
	prune = 2,
	prepare_soil = 3,
	heal = 4
}

func _ready() -> void:
	Events.connect("selected_flower", self, 'on_flower_selected')
	Events.connect("selected_action", self, 'on_action_selected')
	Events.connect("finished_showing_title", self, 'on_title_finished')
	Events.connect("closed_diary", self, 'on_diary_closed')


func on_flower_selected(pos: Vector2, plant: Plant) -> void:
	current_flower = plant
	if first_flower_of_day == null:
		first_flower_of_day = plant
		
	$RadialMenu.show_buttons(pos, plant.needs)


func on_action_selected(action: String) -> void:
	current_flower.call(action)
	play_action_sfx(action)

	if get_all_needs_fullfilled():
		end_day()
	
	
func end_day() -> void:
	$Diary.open(current_day, first_flower_of_day)
	

func start_day() -> void:
	current_flower = null
	first_flower_of_day = null
	current_day += 1
	Events.emit_signal("started_day", current_day)


func on_title_finished() -> void:
	$Diary.open(current_day, first_flower_of_day)
	$BGM/opening.stop()
	$BGM/ambience.play()


func on_diary_closed() -> void:
	if current_day < 11:
		start_day()
	else:
		$Credits.show()
		$BGM/opening.play()
		$BGM/ambience.stop()


func get_all_needs_fullfilled() -> bool:
	var all_needs_fullfilled = true
	for plant in $Plants.get_children():
		if not plant.has_all_needs_fullfilled():
			all_needs_fullfilled = false
			break

	return all_needs_fullfilled


func play_action_sfx(action) -> void:
	$SFX.get_child(SFXS[action]).play()
