extends Button

@onready var button_hover_sound: AudioStreamPlayer = $ButtonHoverSound
@onready var button_down_sound: AudioStreamPlayer = $ButtonDownSound
@onready var button_up_sound: AudioStreamPlayer = $ButtonUpSound
@onready var button_up_sound_2: AudioStreamPlayer = $ButtonUpSound2
@onready var button_up_sound_3: AudioStreamPlayer = $ButtonUpSound3
@onready var button_mouse_exited_sound: AudioStreamPlayer = $ButtonMouseExitedSound

var is_mouse_hovering: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_on_button_mouse_entered)
	mouse_exited.connect(_on_button_mouse_exited)
	button_down.connect(_on_button_button_down)
	button_up.connect(_on_button_button_up)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_mouse_entered():
	is_mouse_hovering = true
	button_hover_sound.play()


func _on_button_mouse_exited():
	is_mouse_hovering = false
	button_mouse_exited_sound.play()


func _on_button_button_down():
	button_down_sound.play()


func _on_button_button_up():
	if is_mouse_hovering:
		button_up_sound.play()
		#button_up_sound_2.play()
		button_up_sound_3.play()
