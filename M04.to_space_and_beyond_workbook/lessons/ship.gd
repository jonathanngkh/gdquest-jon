extends Sprite2D

var normal_speed := 600
var max_speed = normal_speed
var boost_speed := 1500
var velocity := Vector2.ZERO
var min_factor := 1.0
var max_factor := 60.0
var steering_factor := clampf(5.0, min_factor, max_factor)

@onready var boost_duration_timer: Timer = $BoostDurationTimer

signal boost_started
signal boost_ended

func _process(delta: float) -> void:
	var direction := Vector2.ZERO
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if direction.length() > 1.0:
		direction = direction.normalized()

	var desired_velocity = max_speed * direction
	var steering_vector = desired_velocity - velocity
	velocity += steering_vector * steering_factor * delta
	
	if Input.is_action_just_pressed("boost"):
		max_speed = boost_speed
		boost_duration_timer.start()
		emit_signal("boost_started")
		
	position += velocity * delta
	
	if direction != Vector2.ZERO:
	# if direction.length() > 0.0: alternative
		rotation = velocity.angle()


func _on_boost_duration_timer_timeout() -> void:
	max_speed = normal_speed
	emit_signal("boost_ended")
