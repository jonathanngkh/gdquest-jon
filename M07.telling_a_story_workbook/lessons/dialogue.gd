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

var dialogue_items: Array[Dictionary] = [
	{"text": "Harmonious Hellos!",
	"expression": expressions["regular"]},
	
	{"text": "I'm Sofia.",
	"expression" : expressions["happy"]},
	
	{"text": "I'll be your scales practice coach.",
	"expression" : expressions["regular"]},
	
	{"text": "Some people find practicing scales bothersome...",
	"expression" : expressions["sad"]},
	
	{"text": "But I love scales!",
	"expression": expressions["happy"]},
	
	{"text": "Let's practice together.",
	"expression": expressions["determined"]},
	
	{"text": "Do...",
	"expression": expressions["regular"]},
	
	{"text": "Re...",
	"expression": expressions["euphoric"]},
	
	{"text": "Mi...",
	"expression": expressions["sad"]},
	
	{"text": "Fa...",
	"expression": expressions["happy"]},
	
	{"text": "So...",
	"expression": expressions["regular"]},
	
	{"text": "So... f...",
	"expression": expressions["angry"]},
	
	{"text": "So... fu...",
	"expression": expressions["determined"]},
	
	{"text": "So... fun!",
	"expression": expressions["happy"]},
]

var seconds_per_character := 0.6/18.0
var current_index: int = 0
var current_item: Dictionary = dialogue_items[current_index]
var current_text: String = current_item["text"]
var text_appearing_duration: float = current_text.length() * seconds_per_character
var talking_playback_position := 0.0

func _ready() -> void:
	next_button.pressed.connect(_on_button_pressed)
	talking_timer.timeout.connect(_on_talking_timer_timeout)
	talk()
	show_text()

func talk() -> void:
	text_appearing_duration = float(current_text.length()) * seconds_per_character
	talking_timer.wait_time = text_appearing_duration
	talking_sound.play(talking_playback_position)
	talking_timer.start()


func _on_talking_timer_timeout() -> void:
	talking_playback_position = talking_sound.get_playback_position()
	talking_sound.stop()


func _on_button_pressed() -> void:
	play_scale()
	advance_dialogue()
	slide_in()


func show_text() -> void:
	current_item = dialogue_items[current_index]
	current_text = current_item["text"]
	rich_text_label.text = current_text
	expression.texture = current_item["expression"]
	talk()
	var tween = create_tween()
	tween.tween_property(rich_text_label, "visible_ratio", 1, text_appearing_duration).from(0.0)


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
	#tween.set_ease(Tween.EASE_IN)
	#tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(body, "modulate:a", 1.0, 0.2).from(0.0)
	
	tween = create_tween()
	#tween.set_ease(Tween.EASE_IN_OUT)
	#tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(body, "scale:y", 0.9, 0.1).from(1.0)
	tween.tween_property(body, "scale:y", 1.0, 0.1).from(0.9)

func play_scale() -> void:
	if current_text == "Let's practice together.":
		$NextButton/Do.play()
	if current_text == "Do...":
		$NextButton/Re.play()
	if current_text == "Re...":
		$NextButton/Mi.play()
	if current_text == "Mi...":
		$NextButton/Fa.play()
	if current_text == "Fa...":
		$NextButton/So.play()
	if current_text == "So...":
		$NextButton/La.play()
	if current_text == "So... f...":
		$NextButton/Ti.play()
	if current_text == "So... fu...":
		$NextButton/Mi.play()
		$NextButton/So.play()
		$"NextButton/High Do".play()
