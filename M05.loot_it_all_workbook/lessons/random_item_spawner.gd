extends Node2D

@onready var timer: Timer = $Timer

var gem_scene := preload("res://lessons/gem.tscn")
var health_pack_scene := preload("res://lessons/health_pack.tscn")
var item_count := 0

var item_scenes := [
	gem_scene,
	health_pack_scene
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.autostart = true
	timer.start()
	timer.timeout.connect(_on_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if item_count < 6:
		var viewport_size := get_viewport_rect().size
		var random_position := Vector2.ZERO
		random_position.x = randf_range(0, viewport_size.x)
		random_position.y = randf_range(0, viewport_size.y)
		var random_item_scene: PackedScene = item_scenes.pick_random()
		var item_instance := random_item_scene.instantiate()
		item_instance.tree_exited.connect(_on_item_tree_exited)
		item_instance.position = random_position
		add_child(item_instance)
		item_count += 1

func _on_item_tree_exited():
	item_count -= 1
