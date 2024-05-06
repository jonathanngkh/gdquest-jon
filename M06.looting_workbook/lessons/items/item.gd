# Script for pickable items. We don't use inheritance here, just composition: an item is any Area2D scene with a child sprite and this script attached. See gem.tscn and health_pack.tscn.
extends Area2D

@onready var canvas_group: CanvasGroup = $CanvasGroup


func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	play_floating_animation()


func play_floating_animation() -> void:
	var tween := create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE)

	var sprite_2d := $CanvasGroup/Sprite2D
	var position_offset := Vector2(0.0, 4.0)
	var duration = randf_range(0.8, 1.2)
	sprite_2d.position = -1.0 * position_offset
	tween.tween_property(sprite_2d, "position", position_offset, duration)
	tween.tween_property(sprite_2d, "position",  -1.0 * position_offset, duration)


func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	var event_is_LMB_clicked: bool = (
		event is InputEventMouseButton and
		event.button_index == MOUSE_BUTTON_LEFT and
		event.is_pressed()
	)
	if event_is_LMB_clicked:
		var tween := create_tween()
		tween.tween_property(self, "scale", Vector2(0.0, 0.0), 0.08)
		tween.finished.connect(queue_free)
		tween.play()


func _on_mouse_entered() -> void:
	print("entered")
	var tween = create_tween()
	var from_thickness := 3.0
	var to_thickness := 6.0
	var tween_duration := 0.08
	#if not is_open:
	tween.tween_method(set_outline_thickness, from_thickness, to_thickness, tween_duration)


func _on_mouse_exited() -> void:
	var tween = create_tween()
	var from_thickness := 6.0
	var to_thickness := 3.0
	var tween_duration := 0.07
	#if not is_open:
	tween.tween_method(set_outline_thickness, from_thickness, to_thickness, tween_duration)

func set_outline_thickness(new_thickness: float) -> void:
	canvas_group.material.set_shader_parameter("line_thickness", new_thickness)
