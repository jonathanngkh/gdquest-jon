extends ColorRect

@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var button: Button = %Button
@onready var prev_button: Button = %PrevButton


var items: Array[String] = [
	"Strings. Ints. Floats. Nulls.",
	"Long ago, the four types lived together in harmony.",
	"Then, everything changed when the typed Array arrived.",
	"Only the Programmer, student of all types, could stop them.",
	"But when the world needed them most, they were studying on GDQuest.",
]
var item_index := 0

func _ready() -> void:
	button.pressed.connect(advance)
	prev_button.pressed.connect(previous)
	show_text()

func show_text() -> void:
	# Make sure to display the text
	rich_text_label.text = items[item_index]


# Increments the index each time is called.
func advance() -> void:
	# make sure to increment the `item_index`
	item_index += 1

	if item_index >= items.size():
		item_index = 0

	show_text()
	# Don't forget to call the show_text function

func previous() -> void:
	# make sure to increment the `item_index`
	item_index -= 1

	if item_index <= -items.size():
		item_index = 0

	show_text()
	# Don't forget to call the show_text function
