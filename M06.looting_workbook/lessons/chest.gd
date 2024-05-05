extends Area2D

@onready var canvas_group: CanvasGroup = $CanvasGroup
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	set_outline_thickness(3.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# best for single events as opposed to continuous input streams, as this function is called once every time user presses and input
func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	# shape_indx used for detecting clicks on bodies with multiple collision shapes. E.g. shooting a mech's arm/chest/leg/head
	# if event is mouse button,
	# if mouse button is lmb or rmb or mmb
	# if mouse button was clicked
	# if mouse button was released
	var event_is_mouse_click: bool = (
		event is InputEventMouseButton and
		event.button_index == MOUSE_BUTTON_LEFT and
		event.is_pressed()
	)
	if event_is_mouse_click:
		open()

#var is_open := false

func open() -> void:
	#if not is_open:
		#is_open = true
	animation_player.play("open")
	input_pickable = false
		#set_outline_thickness(3.0)

func _on_mouse_entered() -> void:
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
	var tween_duration := 0.08
	#if not is_open:
	tween.tween_method(set_outline_thickness, from_thickness, to_thickness, tween_duration)

func set_outline_thickness(new_thickness: float) -> void:
	canvas_group.material.set_shader_parameter("line_thickness", new_thickness)
