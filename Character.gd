extends Node

class_name Character

enum class_options {ARCHER, KNIGHT, MAGE, BARD}

var char_name: String
var health: int
var attack: int
var defense: int
var abilities = [archerability]
var char_class: class_options

@onready 
var health_label = get_node("../HealthLabel")
@onready 
var attack_label = get_node("../AttackLabel")

func _init(char_name: String, char_class: class_options, health: int, attack: int, defense: int):
	self.char_name = char_name
	self.char_class = char_class
	self.health = health
	self.attack = attack
	self.defense = defense

# Called when the node enters the scene tree for the first time.
func _ready():
	update_labels()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_labels()
	pass

func update_labels():
	health_label.text = str(health)
	attack_label.text = str(attack)
	
func executeAbility(battle: BattleManager):
	for i in range(abilities.size()):
		abilities[i].ExecuteAbility(battle)
	
