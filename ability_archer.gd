extends ability
class_name archerability

var rng = RandomNumberGenerator.new()
var randomTarget = 0;
func createTarget(battle: BattleManager):
	randomTarget = rng.randf_range(0, battle.team2.size())
func ExecuteAbility(battle: BattleManager):
	battle.team2[randomTarget].health -= 1
