extends Sprite2D

var velocity := Vector2(480, 480)

func _process(delta: float) -> void:
	position += velocity * delta
	rotation = velocity.angle()
