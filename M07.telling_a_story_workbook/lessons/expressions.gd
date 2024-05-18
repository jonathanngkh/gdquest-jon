extends Control

@onready var body: TextureRect = %Body
@onready var expression: TextureRect = %Expression
@onready var row_characters: HBoxContainer = %RowCharacters
@onready var row_expressions: HBoxContainer = %RowExpressions

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

func create_button(from_dictionary, dictionary_key) -> void:
	var button := Button.new()
	if from_dictionary == characters:
		row_characters.add_child(button)
	elif from_dictionary == expressions:
		row_expressions.add_child(button)
	var key = dictionary_key
	button.text = key.capitalize()
	button.pressed.connect(func() -> void:
		if from_dictionary == characters:
			body.texture = characters[key]
		elif from_dictionary == expressions:
			expression.texture = expressions[key]
	)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body.texture = characters["pink"]
	expression.texture = expressions["happy"]
	for character:String in characters:
		create_button(characters, character)
	for expression:String in expressions:
		create_button(expressions, expression)
	
	#button_pink.pressed.connect(func() -> void:
		#body.texture = characters["pink"])
	#button_sofia.pressed.connect(func() -> void:
		#body.texture = characters["sofia"])
	#button_happy.pressed.connect(func() -> void:
		#expression.texture = expressions["happy"])
	#button_angry.pressed.connect(func() -> void:
		#expression.texture = expressions["angry"])
	#button_sad.pressed.connect(func() -> void:
		#expression.texture = expressions["sad"])
	#button_regular.pressed.connect(func() -> void:
		#expression.texture = expressions["regular"])
		
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
