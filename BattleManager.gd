extends Node

class_name BattleManager

# Both teams march onto the battlefield
# Both teams heads attack
# Check if the team can be "crunched"
#

var team1 = []
var team2 = []

var character_asset = load("res://char.tscn")

func _ready():
	# Create characters
	team1.append(create_character("Knight1", Character.class_options.KNIGHT, 120, 20, 10))
	team1.append(create_character("Mage1", Character.class_options.MAGE, 80, 25, 5))
	team1.append(create_character("Archer1", Character.class_options.ARCHER, 100, 15, 5))
	
	team2.append(create_character("Archer2", Character.class_options.ARCHER, 100, 15, 5))
	
	# Start battle
	start_battle()
	
func create_character(name: String, class_option: Character.class_options, hp: int, atk: int, def: int) -> Node:
	var new_char = character_asset.instantiate()
	add_child(new_char)
	new_char.initialize(name, class_option, hp, atk, def)
	return new_char

func start_battle():
	# Position characters on the battlefield
	for i in range(team1.size()):
		team1[i].position = Vector2((i + 1) * 200, 100)
		
	for i in range(team2.size()):
		team2[i].position = Vector2((i + 1) * -200, 100)
		
	# Simulate rounds
	while can_battle():
		fight_round()
		await get_tree().create_timer(0.4).timeout
	
func can_battle() -> bool:
	print("Can battle!")
	return team1.size() > 0 && team2.size() > 0
	
func fight_round():
	var attacker1 = team1[0] as Character
	var attacker2 = team2[0] as Character

	print("Damage!")
	attacker1.health -= attacker2.attack
	attacker2.health -= attacker1.attack
	
	#for character in team1:
		#character.execute_abilities(self)
		#
	#for character in team2:
		#character.execute_abilities(self)
	
	var kill1 = team1.filter(is_alive)
	var kill2 = team2.filter(is_alive)
	
	var kill = kill1 + kill2
	
	
	
	pass

func is_alive(character: Character) -> bool:
	return character.health > 0
