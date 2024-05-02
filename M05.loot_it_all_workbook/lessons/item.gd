extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)
	# var tween := create_tween()
	# tween.tween_property(node, "property", target_value, duration).from(initial_value).set_ease(Tween.EASE_IN/OUT/IN_OUT/OUT_IN).set_trans(TRANS_*)
	play_floating_animation()
	


func play_floating_animation():
	var tween := create_tween()
	var position_offset := Vector2(0, 4.0)
	var duration := randf_range(0.8, 1.2)
	tween.finished.connect(_on_tween_finished)
	tween.tween_property(sprite_2d, "position", position_offset, duration).set_trans(Tween.TRANS_SINE)
	tween.tween_property(sprite_2d, "position",  -1.0 * position_offset, duration).set_trans(Tween.TRANS_SINE)
	#tween.set_loops(999)

func _on_tween_finished() -> void:
	play_floating_animation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(area_that_entered: Area2D) ->void:
	queue_free()
