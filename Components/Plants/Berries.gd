extends Plant

const growing = preload('res://assets/flowers/blueberry_2.png')
const grown = preload('res://assets/flowers/blueberry_3.png')


func on_day_start(day) -> void:
	.on_day_start(day)
	match day:
		1, 3, 4, 5, 7, 9:
			$Flower.texture = growing
		2, 6, 8:
			$Flower.texture = growing
