extends Control

@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton
@onready var talking_sound: AudioStreamPlayer = $TalkingSound
@onready var talking_timer: Timer = $TalkingTimer

var dialogue_items: Array[String] = [
	"Harmonious Hellos!",
	"I'm Sofia.",
	"I love scales!",
	"Let's practice together.",
	"Do...",
	"Re...",
	"Mi...",
	"Fa...",
	"So...",
	"So... f...",
	"So... fu...",
	"So... fun!",
]
var seconds_per_character := 0.6/18.0
var current_index: int = 0
var current_item: String = dialogue_items[current_index]
var text_appearing_duration: float = current_item.length() * seconds_per_character
var talking_playback_position := 0.0

func _ready() -> void:
	next_button.pressed.connect(_on_button_pressed)
	talking_timer.timeout.connect(_on_talking_timer_timeout)
	talk()
	show_text()


func talk() -> void:
	text_appearing_duration = float(current_item.length()) * seconds_per_character
	print(current_item.length() * seconds_per_character)
	talking_timer.wait_time = text_appearing_duration
	talking_sound.play(talking_playback_position)
	talking_timer.start()


func _on_talking_timer_timeout() -> void:
	talking_playback_position = talking_sound.get_playback_position()
	talking_sound.stop()


func _on_button_pressed() -> void:
	play_scale()
	advance_dialogue()


func show_text() -> void:
	current_item = dialogue_items[current_index]
	rich_text_label.text = current_item
	var dialogue_before_scale_starts_or_last_line: bool = (
		current_index <= 3 or
		current_index == dialogue_items.size() -1 
	)
	talk()
	if dialogue_before_scale_starts_or_last_line:
		var tween = create_tween()
		tween.tween_property(rich_text_label, "visible_ratio", 1, text_appearing_duration).from(0.0)


func advance_dialogue() -> void:
	if current_index + 1 < dialogue_items.size():
		current_index += 1
		current_item = dialogue_items[current_index]
	show_text()


func play_scale() -> void:
	if current_item == "Let's practice together.":
		$NextButton/Do.play()
	if current_item == "Do...":
		$NextButton/Re.play()
	if current_item == "Re...":
		$NextButton/Mi.play()
	if current_item == "Mi...":
		$NextButton/Fa.play()
	if current_item == "Fa...":
		$NextButton/So.play()
	if current_item == "So...":
		$NextButton/La.play()
	if current_item == "So... f...":
		$NextButton/Ti.play()
	if current_item == "So... fu...":
		$NextButton/Mi.play()
		$NextButton/So.play()
		$"NextButton/High Do".play()
