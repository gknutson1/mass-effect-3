extends Control

var gold = 40

@onready
var partyPanel: HBoxContainer = get_node("TabContainer/Adventurers/PartyPanel")
@onready
var tavernPanel: HBoxContainer = get_node("TabContainer/Adventurers/BuildingPanel/Tavern/TavernPanel")
@onready
var weaponPanel: HBoxContainer = get_node("TabContainer/Adventurers/BuildingPanel/Weaponsmith/WeaponPanel")
@onready
var armourPanel: HBoxContainer = get_node("TabContainer/Adventurers/BuildingPanel/Armoursmith/ArmourPanel")

@onready
var goldLabel: Label = get_node("Label")

func resolve(chr_cls: Character.class_options ) -> String:
	match chr_cls:
		Character.class_options.ARCHER:
			return "Archer"
		Character.class_options.KNIGHT:
			return "Knight"
		Character.class_options.MAGE:
			return "Mage"
		Character.class_options.BARD:
			return "Bard"
	return ""

var update_character_box = func(char: Character) -> String:
	if char != null:
		return "[center]{}\n\nclass:{}\natk: {}\nhp: {}\ndef: {}[/center]".format(
			[char.char_name, resolve(char.char_class), char.attack, char.health, char.defense], "{}"
		)
	else:
		return "[center]Slot\nAvailable![/center]"
		
var update_tavern_box = func(char: Character) -> String:
	#print("parsing!!!")
	return "[center]{}\n\nclass: {}\natk: {}\nhp: {}\ndef: {}[/center]".format(
		[char.char_name, resolve(char.char_class), char.attack, char.health, char.defense], "{}"
	)

class selectionBox:
	var obj
	var string_func: Callable
	var box: VBoxContainer
	var label: RichTextLabel
	var button: Button
	
	func _init(buttonText: String, targetPanel: HBoxContainer, string_func, default_str: bool = true):
		self.string_func = string_func
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
		if default_str == true:
			update_text()
		
	func update_object(obj):
		self.obj = obj
		update_text()
	
	func update_text():
		print(string_func.call(self.obj))
		self.label.text = string_func.call(self.obj)

var characters: Array[selectionBox] = []
var tavern_opts: Array[selectionBox] = []
var weapon_opts: Array[selectionBox] = []
var armour_opts: Array[selectionBox] = []

var partysize: int = 3
var tavernsize: int = 3
var tavernlevel: int = 0
var weaponsize: int = 3
var weaponlevel: int = 0
var armoursize: int = 3
var armourlevel: int = 0

func writeTavern():
	tavern_opts.clear()
	for i in range(0, tavernsize):
		tavern_opts.append(selectionBox.new("Purchase", tavernPanel, update_tavern_box, false))
		randomize()
		var atk = randi() % 21 + 10
		randomize()
		var def = randi() % 21 + 10
		randomize()
		var hp = randi() % 21 + 10
		randomize()
		var cost = randi() % 21 + 10
		var chr = Character.new().initialize("sdf", Character.class_options[Character.class_options.keys()[randi() % Character.class_options.size()]], hp, atk, def, cost)
		tavern_opts[i].update_object(chr)
	writeTavernGold()
		
func writeTavernGold():
	for i in tavern_opts:
		i.button.disabled = i.obj.cost > gold
		i.button.text = "Purchase (" + str(i.obj.cost) + ")"
		i.button.pressed.connect(purchaseChr.bind(i))

func purchaseChr(box: selectionBox):
	gold = gold - box.obj.cost
	goldLabel.text = "Gold: " + str(gold)
	for i in tavern_opts:
		i.button.disabled = i.obj.cost >= gold
	for i in characters:
		i.button.disabled = false
		i.button.pressed.connect(replaceChr.bind(box, i))
		
func replaceChr(new: selectionBox, old: selectionBox):
	old.update_object(new.obj)
	new.obj = null 
	new.button.text = "Purchased!"
	new.button.disabled = true
	for i in characters: 
		i.button.disabled = true

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, partysize):
		characters.append(selectionBox.new("Apply", partyPanel, update_character_box))
	
	goldLabel.text = "Gold: " + str(gold)
	
	writeTavern()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
