extends ability
class_name ability_archer

var rng = RandomNumberGenerator.new()
var randomTarget = 0;

func initialize():
	pass
	
func createTarget(battle: BattleManager):
	randomTarget = rng.randf_range(0, battle.team2.size())
	
func ExecuteAbility(battle: BattleManager):
	print(randomTarget)
	battle.team2[randomTarget].health -= 1
