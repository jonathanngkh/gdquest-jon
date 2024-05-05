extends Area2D

@onready var canvas_group: CanvasGroup = $CanvasGroup
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var possible_items: Array[PackedScene] = [] # if selected in the inspector, those packed scenes become auto pre-loaded


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	set_outline_thickness(3.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _spawn_random_item() -> void:
	var loot_item: Area2D = possible_items.pick_random().instantiate()
	#loot_item.position = Vector2(loot_item.position.x + randi_range(-65, 65), loot_item.position.y + randi_range(-65, 65)) # simple rand distance and angle
	var starting_angle = 0.0 # 0 radians points to the right
	var ending_angle = 2.0 * PI # 2π = 360 degrees, so one full circle
	var random_angle := randf_range(starting_angle, ending_angle)
	
	var random_direction := Vector2(1.0, 0.0).rotated(random_angle) # random direction is a unit vector pointing right, rotated at a random angle
	
	var min_dist_to_chest = 60
	var max_dist_to_chest = 120
	var random_distance := randf_range(min_dist_to_chest, max_dist_to_chest)
	
	loot_item.position = random_direction * random_distance
	add_child(loot_item)

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
		
	if possible_items.is_empty():
		print("possible items is empty")
		return
		
	for i in range(randi_range(1, 3)):
		_spawn_random_item()

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
	var tween_duration := 0.07
	#if not is_open:
	tween.tween_method(set_outline_thickness, from_thickness, to_thickness, tween_duration)

func set_outline_thickness(new_thickness: float) -> void:
	canvas_group.material.set_shader_parameter("line_thickness", new_thickness)
