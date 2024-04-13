extends Node2D

class_name BattleManager

# Both teams march onto the battlefield
# Both teams heads attack
# Check if the team can be "crunched"
#

var team1 = []
var team2 = []

func start_battle():
	while can_battle():
		fight_round()
		
	pass
	
func can_battle() -> bool:
	return team1.size() > 0 && team2.size() > 0
	pass
	
func fight_round():
	var attacker1 = team1[0]
	var attacker2 = team2[0]
	
	is_instance_of(attacker1, Character)
	pass
