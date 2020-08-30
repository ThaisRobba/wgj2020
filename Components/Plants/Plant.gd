class_name Plant
extends Area2D

export var base_day := 0

var needs = {
	water = false,
	heal = false,
	dialog = false,
	prune = false,
	prepare_soil = false
}

var chances = {
	water = 100,
	heal = 20,
	prune = 30,
	dialog = 10,
	prepare_soil = 30
}

var interactible = false

func _ready() -> void:
	connect("input_event", self, '_on_Area2D_input_event')
	Events.connect("started_day", self, 'on_day_start')
	$Flower.visible = false
	
	
func refresh_needs() -> void:
	for need in needs.keys():
		needs[need] = rand_range(0, 100) <= chances[need]


func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if interactible and event.is_action_released('click'):
		Events.emit_signal("selected_flower", event.position, self)


func on_day_start(day:int) -> void:
	if day >= base_day:
		interactible = true
		$Flower.visible = true
		refresh_needs()


func water() -> void:
	needs.water = false
	

func heal() -> void:
	needs.heal = false
	
	
func dialog() -> void:
	needs.dialog = false
	
	
func prune() -> void:
	needs.prune = false
	

func prepare_soil() -> void:
	needs.prepare_soil = false


func has_all_needs_fullfilled() -> bool:
	for need in needs.keys():
		if needs[need]:
			return false
	return true
