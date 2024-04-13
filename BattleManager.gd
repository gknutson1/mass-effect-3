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
	
	add_child(char1)
	add_child(char2)
	
	team1 = [char1]
	team2 = [char2]
	pass

func start_battle():
	print(team1.size())
	for i in range(team1.size()):
		print("Ping!")
		var character = team1[i]
		character.position = Vector2((i + 1) * 100, 100)
		
	for i in range(team1.size()):
		print("Pong!")
		var character = team1[i]
		character.position = Vector2((i + 1) * 100, 300)
		
	while can_battle():
		fight_round()
		await get_tree().create_timer(0.4).timeout
	pass
	
func can_battle() -> bool:
	return team1.size() > 0 && team2.size() > 0
	
func fight_round():
	var attacker1 = team1[0]
	var attacker2 = team2[0]
	
	if !(attacker1 is Character && attacker2 is Character):
		return
		
	attacker1.health -= attacker2.attack
	attacker2.health -= attacker1.attack
	
	for character in team1:
		character.execute_abilities(self)
		
	for character in team2:
		character.execute_abilities(self)
	
	team1.filter(is_alive)
	team2.filter(is_alive)
	
	pass

func is_alive(character) -> bool:
	return character.health > 0
