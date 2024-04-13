extends Character
class_name BattleManager

var team1 = []
# Called when the node enters the scene tree for the first time.
func _ready():
	var char1 = Character.new("joe1", 5, 5, 5)
	var char2 = Character.new("joe2", 5, 5, 5)
	var char3 = Character.new("joe3", 5, 5, 5)
	team1 = [char1, char2, char3]
	print("test")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("test")
	pass
