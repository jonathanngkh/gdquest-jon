extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var shadow: Sprite2D = $Shadow
@onready var timer: Timer = $Timer

var shadow_default_scale := Vector2(1.563, 0.977)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = randf_range(0.5, 1.5)
	timer.timeout.connect(_on_timer_timeout)
	timer.set_autostart(true)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	timer.wait_time = randf_range(0.5, 1.5)
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.play()

	var random_jump_distance := randf_range(20, 40)
	var random_direction = [-1, 1].pick_random()
	if random_direction > 0:
		sprite_2d.flip_h = true
		#shadow.position.x = 13
	else:
		sprite_2d.flip_h = false
		#shadow.position.x = 0

	tween.tween_property(sprite_2d, "position:x", sprite_2d.position.x + random_jump_distance * random_direction, 0.2).set_ease(Tween.EASE_OUT)
	tween = create_tween()
	tween.tween_property(shadow, "position:x", sprite_2d.position.x + (random_jump_distance + 6) * random_direction, 0.2).set_ease(Tween.EASE_OUT)

	tween = create_tween()
	var jump_height := 20
	tween.tween_property(sprite_2d, "position:y", sprite_2d.position.y - jump_height, 0.1).set_ease(Tween.EASE_IN)
	tween.tween_property(sprite_2d, "position:y", sprite_2d.position.y, 0.1).set_ease(Tween.EASE_IN)
	
	tween = create_tween()
	var target_scale_multiplier = 0.5
	tween.tween_property(shadow, "scale", shadow.scale * target_scale_multiplier, 0.1).set_ease(Tween.EASE_IN)
	tween.tween_property(shadow, "scale", shadow_default_scale, 0.1).set_ease(Tween.EASE_IN)
