extends Object

class_name Character

enum class_options {ARCHER, KNIGHT, MAGE, BARD}

var char_name: String
var health: int
var attack: int
var defense: int
var char_class: class_options

func _init(char_name: String, char_class: class_options, health: int, attack: int, defense: int):
	self.char_name = char_name
	self.char_class = char_class
	self.health = health
	self.attack = attack
	self.defense = defense
