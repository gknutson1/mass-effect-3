extends Node2D  # Assuming your character extends from Node2D for position manipulation

class_name Character

enum class_options {ARCHER, KNIGHT, MAGE, BARD}
enum state {IDLE, DEAD, ATTACKING}

var cost: int
var char_name: String
var health: int
var attack: int
var defense: int
var char_class: class_options
var target_position: Vector2
var attack_target: Node2D
var velocity: Vector2 = Vector2.ZERO
var char_state: state
var gravity: float = 500.0
var abilities = []

@onready 
var health_label = get_node("HealthLabel")
@onready 
var attack_label = get_node("AttackLabel")
@onready 
var sprite_2d = get_node("Sprite2D")

func initialize(char_name: String, char_class: class_options, health: int, attack: int, defense: int, cost: int = 0):
	self.cost = cost
	self.char_name = char_name
	self.char_class = char_class
	self.health = health
	self.attack = attack
	self.defense = defense
	self.abilities.append(ability_archer.new())
	#char19 is archer
	#char7 is knight
	#char22 is mage
	#char47 is bard
	#char49 is barbarian
	
	#char46 is bear
	#char44 is tiger
	#char35 
	if(char_class == class_options.MAGE):
		self.abilities.append(ability_magic.new())
	if(char_class == class_options.ARCHER):
		self.abilities.append(ability_archer.new())
	update_labels()
	return self

func update_labels():
	if is_inside_tree():
		health_label.text = str(health)
		attack_label.text = str(attack)

func _ready():
	update_labels()

func _process(delta):
	update_labels()
	if health <= 0:
		char_state = state.DEAD
		kill()
	if char_state == state.IDLE:
		move_animation(delta)
	elif char_state == state.DEAD:
		death_animation(delta)
	elif char_state == state.ATTACKING:
		attack_animation(delta)		

func move_animation(delta):
	self.position = lerp(self.position, target_position, 0.2)

func kill():
	if char_state != state.DEAD:
		velocity = Vector2(randf_range(-10000, 10000), randf_range(-30000, -10000))  # Random initial upward velocity

func death_animation(delta):
	velocity.y += gravity * delta
	position += velocity * delta
	if position.y > get_viewport_rect().size.y + 100:  # Check if out of screen
		queue_free()  # Remove the node from the scene
		
func set_attack_target(target: Node2D):
	attack_target = target
	char_state = state.ATTACKING
	
func attack_animation(delta):
	self.position = lerp(self.position, attack_target.position, 0.5)
	if (self.position - attack_target.position).length() < 50:
		deal_damage(attack_target)
		char_state = state.IDLE
	pass

func deal_damage(target):
	var target_character = target as Character
	target_character.health -= self.attack
	if target_character.health <= 0:
		char_state = state.IDLE
		
func execute_abilities(battle: BattleManager, team: int,cCarcter: int):
	for cAbility in abilities:
		
		cAbility.createTarget(battle,team)
		cAbility.ExecuteAbility(battle, team,cCarcter)
