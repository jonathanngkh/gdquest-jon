extends Control

@onready var button_sofia: Button = %ButtonSofia
@onready var button_pink: Button = %ButtonPink
@onready var button_regular: Button = %ButtonRegular
@onready var button_happy: Button = %ButtonHappy
@onready var button_sad: Button = %ButtonSad
@onready var button_angry: Button = %ButtonAngry
@onready var body: TextureRect = $Body
@onready var expression: TextureRect = $Body/Expression

var expressions: Dictionary = {
	"regular" = preload("res://assets/emotion_regular.png"),
	"happy" = preload("res://assets/emotion_happy.png"),
	"angry" = preload("res://assets/extras/emotion_angry.png"),
	"sad" = preload("res://assets/emotion_sad.png")
}


var characters: Dictionary = {
	"pink" = preload("res://assets/pink.png"),
	"sofia" = preload("res://assets/sophia.png")
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body.texture = characters["pink"]
	expression.texture = expressions["happy"]
	button_pink.pressed.connect(func() -> void:
		body.texture = characters["pink"])
	button_sofia.pressed.connect(func() -> void:
		body.texture = characters["sofia"])
	button_happy.pressed.connect(func() -> void:
		expression.texture = expressions["happy"])
	button_angry.pressed.connect(func() -> void:
		expression.texture = expressions["angry"])
	button_sad.pressed.connect(func() -> void:
		expression.texture = expressions["sad"])
	button_regular.pressed.connect(func() -> void:
		expression.texture = expressions["regular"])
	#button_pink.pressed.connect(_on_button_pink_pressed)
	#button_sofia.pressed.connect(_on_button_sofia_pressed)
	#button_happy.pressed.connect(_on_button_happy_pressed)
	#button_angry.pressed.connect(_on_button_angry_pressed)
	#button_sad.pressed.connect(_on_button_sad_pressed)
	#button_regular.pressed.connect(_on_button_regular_pressed)


#func _on_button_pink_pressed() -> void:
	#body.texture = characters["pink"]
#
#
#func _on_button_sofia_pressed() -> void:
	#body.texture = characters["sofia"]
#
#
#func _on_button_happy_pressed() -> void:
	#expression.texture = expressions["happy"]
#
#
#func _on_button_sad_pressed() -> void:
	#expression.texture = expressions["sad"]
#
#
#func _on_button_regular_pressed() -> void:
	#expression.texture = expressions["regular"]
#
#
#func _on_button_angry_pressed() -> void:
	#expression.texture = expressions["angry"]
