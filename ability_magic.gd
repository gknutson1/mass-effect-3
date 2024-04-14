extends Node
class_name ability_magic

var damage =1
func initialize():
	pass
func createTarget(battle: BattleManager,team: int):
	pass
func ExecuteAbility(battle: BattleManager,team: int,cCharcter: int):
	if(cCharcter == 0):
		print("magic attack team " + str(team))
		if(team == 1):
			for enemies in battle.team1:
				enemies.health -=damage
		if(team == 2):
			for enemies in battle.team2:
				enemies.health -=damage
	else:
		pass

