extends ability
class_name ability_archer

var rng = RandomNumberGenerator.new()
var randomTarget = 0;

func initialize():
	pass
func createTarget(battle: BattleManager,team: int):
	if(team == 1):
		randomTarget = rng.randf_range(0, battle.team1.size())
	if(team == 2):
		randomTarget = rng.randf_range(0, battle.team2.size())
func ExecuteAbility(battle: BattleManager,team: int):
	print("archer attack" + str(team))
	if(team == 1):
		battle.team1[randomTarget].health -= 1
	if(team == 2):
		battle.team2[randomTarget].health -= 1
