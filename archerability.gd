extends ability
class_name archerability

func ExecuteAbility(battle: BattleManager):
	battle.team1[0].health +=1
