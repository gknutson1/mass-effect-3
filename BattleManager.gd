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
	var char1 = character_asset.instantiate()
	var char2 = character_asset.instantiate()
	var char3 = character_asset.instantiate()
	var char4 = character_asset.instantiate()
	
	add_child(char1)
	add_child(char2)
	add_child(char3)
	add_child(char4)
	
	team2 = [char1]
	team1 = [char2, char3, char4]
	
	start_battle()
	pass

func start_battle():
	for i in range(team1.size()):
		var character = team1[i]
		character.position = Vector2((i + 1) * 200, 0)
		
	for i in range(team2.size()):
		var character = team2[i]
		character.position = Vector2((i + 1) * -200, 0)
		
	while can_battle():
		fight_round()
		await get_tree().create_timer(0.4).timeout
	pass
	
func can_battle() -> bool:
	print("Can battle!")
	return team1.size() > 0 && team2.size() > 0
	
func fight_round():
	var attacker1_obj = team1[0]
	var attacker2_obj = team2[0]
	
	var attacker1 = attacker1_obj.get_node("Character") as Character
	var attacker2 = attacker2_obj.get_node("Character") as Character
		
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
