extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
#Эта штука задает спрайт улитки
@onready var spriteSnail : Sprite2D = $Sprite2D

@export var starting_move_direction : Vector2 = Vector2.LEFT

@export var movement_speed : float = 30.0
@export var hit_state : State

@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

func _ready():
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle movement and direction change
	if state_machine.check_if_can_move():
		velocity.x = starting_move_direction.x * movement_speed
		
		# Check for collision and reverse direction
		var collision_info = move_and_slide()
		if collision_info and is_on_wall():
			_reverse_direction()
	else:
		if state_machine.current_state != hit_state:
			velocity.x = move_toward(velocity.x, 0, movement_speed)

	move_and_slide()
	update_facing_direction()

func _reverse_direction() -> void:
	starting_move_direction = -starting_move_direction
	
func update_facing_direction():
	if starting_move_direction.x < 0:
		spriteSnail.flip_h = false
	elif starting_move_direction.x > 0:
		spriteSnail.flip_h = true
