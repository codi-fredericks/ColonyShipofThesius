class_name RichButton
extends MarginContainer

signal pressed()

var rich_text: RichTextLabel
var button: Button

func _ready() -> void:
	rich_text = %RichTextLabel
	button = %Button

	button.pressed.connect(_on_button_pressed)


func set_disabled(state: bool) -> void:
	button.disabled = state

	var plaintext: String = rich_text.get_parsed_text()
	rich_text.text = ""

	if state:
		rich_text.push_color(ColorManager.get_disabled_color())

	rich_text.append_text(plaintext)
	rich_text.pop_all()



func _on_button_pressed() -> void:
	pressed.emit()


