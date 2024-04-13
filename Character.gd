extends Node

class_name Character

var health = 1;
var attack = 0;
var defense = 0;

@onready var health_label = get_node("../HealthLabel")
@onready var attack_label = get_node("../AttackLabel")

func initialize(health: int, attack: int, defense: int) -> Character:
	self.health = health
	self.attack = attack
	self.defense = defense
	return self
	
func new():
	pass

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
