extends Control

@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton
@onready var talking_sound: AudioStreamPlayer = $TalkingSound
@onready var talking_timer: Timer = $TalkingTimer
@onready var body: TextureRect = %Body
@onready var expression: TextureRect = %Expression

var expressions: Dictionary = {
	"regular" = preload("res://assets/emotion_regular.png"),
	"happy" = preload("res://assets/emotion_happy.png"),
	"angry" = preload("res://assets/extras/emotion_angry.png"),
	"determined" = preload("res://assets/extras/emotion_determined.png"),
	"sad" = preload("res://assets/emotion_sad.png"),
	"euphoric" = preload("res://assets/emotion_euphoric.png"),
}

var characters: Dictionary = {
	"pink" = preload("res://assets/pink.png"),
	"sofia" = preload("res://assets/sophia.png")
}

var dialogue_items: Array[Dictionary] = [
	{"text": "[b]Harmonious[/b] Hellos!",
	"expression": expressions["regular"],
	"character": characters["sofia"]},
	
	{"text": "I'm Sofia.",
	"expression" : expressions["happy"],
	"character": characters["sofia"]},
	
	{"text": "I'll be your scales practice coach.",
	"expression" : expressions["regular"],
	"character": characters["sofia"]},
	
	{"text": "But I prefer playing pieces!",
	"expression" : expressions["angry"],
	"character": characters["pink"]},
	
	{"text": "Some people find practicing scales boring...",
	"expression" : expressions["sad"],
	"character": characters["sofia"]},
	
	{"text": "But I love scales!",
	"expression": expressions["happy"],
	"character": characters["sofia"]},
	
	{"text": "Let's practice together.",
	"expression": expressions["determined"],
	"character": characters["sofia"]},
	
	{"text": "Do...",
	"expression": expressions["regular"],
	"character": characters["sofia"]},
	
	{"text": "Re...",
	"expression": expressions["euphoric"],
	"character": characters["pink"]},
	
	{"text": "Mi...",
	"expression": expressions["sad"],
	"character": characters["sofia"]},
	
	{"text": "Fa...",
	"expression": expressions["happy"],
	"character": characters["pink"]},
	
	{"text": "So...",
	"expression": expressions["regular"],
	"character": characters["sofia"]},
	
	{"text": "So... f...",
	"expression": expressions["angry"],
	"character": characters["sofia"]},
	
	{"text": "So... fu...",
	"expression": expressions["determined"],
	"character": characters["sofia"]},
	
	{"text": "So... fun!",
	"expression": expressions["happy"],
	"character": characters["pink"]},
]

@export var sofia_pitch_scale := 1.5
@export var pink_pitch_scale := 0.9
var seconds_per_character := 0.6/18.0
var current_index: int = 0
var current_item: Dictionary = dialogue_items[current_index]
var text_appearing_duration: float = current_item["text"].length() * seconds_per_character
var talking_playback_position := 0.0

func _ready() -> void:
	next_button.pressed.connect(_on_button_pressed)
	talking_timer.timeout.connect(_on_talking_timer_timeout)
	talk()
	show_text()


func talk() -> void:
	text_appearing_duration = float(current_item["text"].length()) * seconds_per_character
	talking_timer.wait_time = text_appearing_duration
	if current_item["character"] == characters["sofia"]:
		talking_sound.pitch_scale = sofia_pitch_scale
	elif current_item["character"] == characters["pink"]:
		talking_sound.pitch_scale = pink_pitch_scale
	talking_sound.play(talking_playback_position)
	talking_timer.start()
	next_button.disabled = true
	next_button.mouse_default_cursor_shape = Control.CURSOR_FORBIDDEN


func _on_talking_timer_timeout() -> void:
	talking_playback_position = talking_sound.get_playback_position()
	talking_sound.stop()
	next_button.disabled = false
	next_button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	$NextButton/ButtonUpSound.play()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("advance_button"):
		if next_button.disabled == false:
			$NextButton/ButtonDownSound.play()
			next_button.button_pressed = true
	if event.is_action_released("advance_button"):
		if next_button.disabled == false:
			_on_button_pressed()


func _on_button_pressed() -> void:
	play_scale()
	advance_dialogue()
	slide_in()
	$NextButton/ButtonUpSound.play()
	next_button.button_pressed = false
	next_button.release_focus()


func show_text() -> void:
	set_text_expression_character()
	talk()
	tween_text()
	
func tween_text() -> void:
	var tween = create_tween()
	tween.tween_property(rich_text_label, "visible_ratio", 1, text_appearing_duration).from(0.0)


func set_text_expression_character() -> void:
	current_item = dialogue_items[current_index]
	rich_text_label.text = current_item["text"]
	expression.texture = current_item["expression"]
	body.texture = current_item["character"]

func advance_dialogue() -> void:
	if current_index + 1 < dialogue_items.size():
		current_index += 1
	show_text()


func slide_in() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(body, "position:x", 194, 0.5).from(400)
	
	tween = create_tween()
	tween.tween_property(body, "modulate:a", 1.0, 0.2).from(0.0)
	
	tween = create_tween()
	tween.tween_property(body, "scale:y", 0.95, 0.1).from(1.0)
	tween.tween_property(body, "scale:y", 1.0, 0.1).from(0.95)

func play_scale() -> void:
	if current_item["text"] == "Let's practice together.":
		$NextButton/Do.play()
	if current_item["text"] == "Do...":
		$NextButton/Re.play()
	if current_item["text"] == "Re...":
		$NextButton/Mi.play()
	if current_item["text"] == "Mi...":
		$NextButton/Fa.play()
	if current_item["text"] == "Fa...":
		$NextButton/So.play()
	if current_item["text"] == "So...":
		$NextButton/La.play()
	if current_item["text"] == "So... f...":
		$NextButton/Ti.play()
	if current_item["text"] == "So... fu...":
		$NextButton/Mi.play()
		$NextButton/So.play()
		$"NextButton/High Do".play()
