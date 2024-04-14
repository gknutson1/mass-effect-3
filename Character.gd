extends Node

class_name Character

enum class_options {ARCHER, KNIGHT, MAGE, BARD}

var char_name: String
var health: int
var attack: int
var defense: int
var char_class: class_options
var abilities = [archerability]

@onready 
var health_label = get_node("HealthLabel")
@onready 
var attack_label = get_node("AttackLabel")

func initialize(char_name: String, char_class: class_options, health: int, attack: int, defense: int):
	self.char_name = char_name
	self.char_class = char_class
	self.health = health
	self.attack = attack
	self.defense = defense
	update_labels()

func update_labels():
	if is_inside_tree():
		health_label.text = str(health)
		attack_label.text = str(attack)

# Called when the node enters the scene tree for the first time.
func _ready():
	update_labels()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_labels()
	pass

func execute_abilities(battle: BattleManager):
	for cAbility in abilities:
		cAbility.createTarget(battle)
		cAbility.ExecuteAbility(battle)
