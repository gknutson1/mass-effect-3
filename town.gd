extends Control

@onready
var partyPanel: HBoxContainer = get_node("TabContainer/Adventurers/PartyPanel")

func update_character_box(char: Character) -> String:
	if char != null:
		return "[center]{}\n\natk: {}\nhp: {}\ndef: {}[/center]".format(
			[char.char_name, char.attack, char.health, char.defense], "{}"
		)
	else:
		return "[center]Slot\nAvailable![/center]"

class selectionBox:
	var obj
	var string_func: Callable
	var box: VBoxContainer
	var label: RichTextLabel
	var button: Button
	
	func _init(buttonText: String, targetPanel: HBoxContainer, string_func):
		self.box = VBoxContainer.new()
		self.label = RichTextLabel.new()
		self.button = Button.new()
		self.box.add_child(self.label)
		self.box.add_child(self.button)
		self.button.text = buttonText
		self.button.disabled = true
		self.box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		self.box.alignment = BoxContainer.ALIGNMENT_END
		self.label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		self.label.fit_content = true
		self.label.bbcode_enabled = true
		targetPanel.add_child(self.box)
		update_text()
		
	func update_char(char: Character):
		self.char = char
		update_text()
	
	func update_text():
		if char != null:
			label.text = "[center]{}\n\natk: {}\nhp: {}\ndef: {}[/center]".format(
				[char.char_name, char.attack, char.health, char.defense], "{}"
			)
		else:
			label.text = "[center]Slot\nAvailable![/center]"

var characters: Array[CharacterBox] = []

var partysize: int = 3
var tavernsize: int = 3
var tavernlevel: int = 0
var weaponsize: int = 3
var weaponlevel: int = 0
var armoursize: int = 3
var armourlevel: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, partysize):
		characters.append(CharacterBox.new("Apply", partyPanel, null))
		
	characters[0].update_char(Character.new("fred", Character.class_options.ARCHER, 1, 5, 6))
	characters[1].update_char(Character.new("chara", Character.class_options.MAGE, 4, 6, 1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass