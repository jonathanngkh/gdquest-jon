extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var health_bar: ProgressBar = $UI/HealthBar
@onready var gem_count_label: Label = $UI/GemCountLabel


var max_speed := 1200.0
var velocity := Vector2(0, 0)
var steering_factor := 3.0
var health := 10.0
var heal_amount := 10
var gem_count := 0

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	set_health(health)


func _process(delta: float) -> void:
	var direction := Vector2(0, 0)
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")

	if direction.length() > 1.0:
		direction = direction.normalized()

	var desired_velocity := max_speed * direction
	var steering := desired_velocity - velocity
	velocity += steering * steering_factor * delta
	position += velocity * delta

	if velocity.length() > 0.0:
		sprite_2d.rotation = velocity.angle()
		collision_polygon_2d.rotation = velocity.angle()


func _on_area_entered(area_that_entered: Area2D) -> void:
	if area_that_entered.is_in_group("healing_item"):
		set_health(health + heal_amount)
	if area_that_entered.is_in_group("gem"):
		set_gem_count(gem_count + 1)


func set_health(new_health: int) -> void:
	health = new_health
	health_bar.value = health


func set_gem_count(new_gem_count: int) -> void:
	gem_count = new_gem_count
	gem_count_label.text = "x" + str(gem_count)
