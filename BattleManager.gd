extends Node

class_name BattleManager

# Both teams march onto the battlefield
# Both teams heads attack
# Check if the team can be "crunched"
#

enum end_state {NONE, T1WIN, T2WIN, DRAW}

var team1 = []
var team2 = []

var character_asset = load("res://char.tscn")

var move_orders = []

func _ready():
	# Create characters
	team1.append(create_character("Knight1", Character.class_options.KNIGHT, 120, 20, 10))
	team1.append(create_character("Mage1", Character.class_options.MAGE, 80, 25, 5))
	team1.append(create_character("Archer1", Character.class_options.ARCHER, 100, 15, 5))
	
	team2.append(create_character("Archer2", Character.class_options.ARCHER, 100, 15, 5))
	team2.append(create_character("Archer3", Character.class_options.ARCHER, 100, 15, 5))
	team2.append(create_character("Archer4", Character.class_options.ARCHER, 100, 15, 5))
	team2.append(create_character("Archer5", Character.class_options.ARCHER, 100, 15, 5))
	
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
		team1[i].position = Vector2((i + 1) * -200, 100)
		
	for i in range(team2.size()):
		team2[i].position = Vector2((i + 1) * 200, 100)
		
	# Simulate rounds
	while can_battle():
		fight_round()
		await get_tree().create_timer(0.4).timeout
	
func can_battle() -> bool:
	var busy_characters = are_characters_busy()
	return team1.size() > 0 && team2.size() > 0

func are_characters_busy() -> bool:
	for character in team1:
		if character.char_state != Character.state.IDLE:
			return true
			
	for character in team2:
		if character.char_state != Character.state.IDLE:
			return true
			
	return false

func fight_round():
	var attacker1 = team1[0] as Character
	var attacker2 = team2[0] as Character
	
	if attacker2.health > 0:
		attacker1.set_attack_target(team2[0])
	
	if attacker1.health > 0:
		attacker2.set_attack_target(team1[0])
	
	#NOTE: We will have to repeat. Character abilities may trigger character abilities. Can't loop once.
	#for character in team1:
		#character.execute_abilities(self)
		##
	#for character in team2:
		#character.execute_abilities(self)
	
	var kill1 = team1.filter(is_dead)
	var kill2 = team2.filter(is_dead)
	
	var kill = kill1 + kill2
	
	for char in kill:
		team1.erase(char)
		team2.erase(char)
		
	assign_move_orders()
		
	var winner = declare_winner()
	
	if winner == end_state.T1WIN:
		print("Team 1 wins!")
	
	if winner == end_state.T2WIN:
		print("Team 2 wins!")
	
	if winner == end_state.DRAW:
		print("Draw!")
	
	pass

func is_dead(character: Character) -> bool:
	return character.health <= 0

func declare_winner() -> end_state:
	if team1.size() == 0 and team2.size() == 0:
		return end_state.DRAW
		
	if team1.size() == 0:
		return end_state.T2WIN
		
	if team2.size() == 0:
		return end_state.T1WIN
		
	return end_state.NONE

func assign_move_orders():
	for i in range(team1.size()):
		var character = team1[i] as Character
		character.target_position = Vector2((i + 1) * -200, 100)
		
	for i in range(team2.size()):
		var character = team2[i] as Character
		character.target_position = Vector2((i + 1) * 200, 100)
		
