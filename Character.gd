extends Node2D  # Assuming your character extends from Node2D for position manipulation

class_name Character

enum class_options {ARCHER, KNIGHT, MAGE, BARD}

var char_name: String
var health: int
var attack: int
var defense: int
var char_class: class_options
var target_position: Vector2
var busy: bool = false
var velocity: Vector2 = Vector2.ZERO  # Physics property
var dead: bool = false  # State check if dead
var gravity: float = 500.0  # Gravity strength
var abilities = []
var archer: ability_archer

@onready 
var health_label = get_node("HealthLabel")
@onready 
var attack_label = get_node("AttackLabel")

func initialize(char_name: String, char_class: class_options, health: int, attack: int, defense: int):
	self.char_name = char_name
	self.char_class = char_class
	self.health = health
	self.attack = attack
	self.defense = defense
	archer = ability_archer.new()
	update_labels()

func update_labels():
	if is_inside_tree():
		health_label.text = str(health)
		attack_label.text = str(attack)

func _ready():
	update_labels()

func _process(delta):
	update_labels()
	if health <= 0:
		dead = true
	if not dead:
		move_to_target(delta)
		busy_check()
	else:
		handle_death_physics(delta)

func move_to_target(delta):
	self.position = lerp(self.position, target_position, 0.2)

func busy_check():
	busy = self.position != target_position or health <= 0

func kill():
	if not dead:
		dead = true
		velocity = Vector2(randf_range(-100, 100), randf_range(-300, -100))  # Random initial upward velocity

func handle_death_physics(delta):
	velocity.y += gravity * delta
	position += velocity * delta
	if position.y > get_viewport_rect().size.y + 100:  # Check if out of screen
		queue_free()  # Remove the node from the scene
func execute_abilities(battle: BattleManager):
	archer.createTarget(battle)
	archer.ExecuteAbility(battle)
