extends Plant

const budding = preload('res://assets/flowers/mementoFlorum_5.png')
const blossoming = preload('res://assets/flowers/mementoFlorum_4.png')
const withering = preload('res://assets/flowers/mementoFlorum_5-dead.png')
const blossomed = preload('res://assets/flowers/mememtoFlorum_ani_3.png')

func on_day_start(day) -> void:
	.on_day_start(day)
	match day:
		4, 7, 9:
			$Flower.texture = budding
		5, 6, 8:
			$Flower.texture = withering
		10:
			$Flower.texture = blossoming
		11:
			$Flower.texture = blossomed
	
