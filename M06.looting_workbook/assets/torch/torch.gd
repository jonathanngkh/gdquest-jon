extends Area2D

@onready var flame: Sprite2D = $Flame

func _ready() -> void:
	# This parameter of the shader material gives each flame a slightly different look and randomized animation.
	flame.material.set("shader_parameter/offset", global_position * 0.1)


func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	var event_is_mouse_click: bool = (
		event is InputEventMouseButton and
		event.button_index == MOUSE_BUTTON_LEFT and
		event.is_pressed()
	)
	if event_is_mouse_click:
		var tween = create_tween()
		if $Flame.visible:
			tween.tween_property($Flame, "scale", Vector2(0.0, 0.0), 0.2)
			tween.finished.connect(toggle_flame_visibility)
		else:
			tween.tween_property($Flame, "scale", Vector2(0.28, 0.28), 0.2)
			toggle_flame_visibility()
		tween.play()

func toggle_flame_visibility():
		$Flame.visible = not $Flame.visible
	
