extends Node2D

var collectible_scenes := [
	preload("res://practices/L7.P1.spawn_random_items/coin.tscn"),
	preload("res://practices/L7.P1.spawn_random_items/energy_pack.tscn")
]


func _ready() -> void:
	get_node("Timer").timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	var random_item_scene:PackedScene =  collectible_scenes.pick_random()
	var item_instance = random_item_scene.instantiate()
	var viewport_size = get_viewport_rect().size
	#var random_position = Vector2.ZERO
	#random_position.x = randf_range(0, viewport_size.x)
	#random_position.y = randf_range(0, viewport_size.y)
	#item_instance.position = random_position
	add_child(item_instance)
