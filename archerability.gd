extends ability
class_name archerability

var rng = RandomNumberGenerator.new()
var randomTarget = 0;
func createTarget(team: Array):
	randomTarget = rng.randf_range(0, team.size())
func ExecuteAbility(team: Array):
	team[randomTarget].health -= 1
