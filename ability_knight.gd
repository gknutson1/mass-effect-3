extends Node
class_name ability_knight

var active =true
var cooldown=0
func initialize():
	pass
func createTarget(battle: BattleManager,team: int):
	pass
func ExecuteAbility(battle: BattleManager,eTeam: int,cCharcter: int):
	if(cCharcter == 0):
		print("shield " + str(team))
		if(eTeam == 1):
			battle.team2[i].defense = 5
			
		if(eTeam == 2):
			if(active == false):
				if(cooldown == 0):
					battle.team1[i].defense = 5
					cooldown = 6;
					active==true;
			if(active == true):
				battle.team1[i].defense = 5
	else:
		pass

