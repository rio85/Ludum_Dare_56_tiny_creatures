extends CharacterBody2D
class_name Player


@export var speed : float = 500.0
@export var acceleration = 5000.0
var friction = acceleration / speed


var jump_speed : float = -1000.0
@export var gravity : Vector2 = Vector2(0, 1500)
@export var gravity_down : float = 5
var wall_gravity : Vector2 = Vector2(0,0)

var max_jumps : int = 1
var current_jumps : int
var can_wall : bool = true

@export var bullet : PackedScene

var cut_jump = 100
var last_dir : float

enum states{move, jump, wall, slide, death}
var state = states.move

var vel : Vector2 = Vector2.ZERO


func _ready() -> void:
	current_jumps = max_jumps

func _physics_process(delta: float) -> void:
	match state:
		states.move:
			move(delta)
		states.jump:
			jump(delta)
		states.wall:
			wall(delta)
			
			
	move_and_slide()


func move(delta):
	print("state move")
	if not is_on_floor():
		state = states.jump
		
	# Jump
	if Input.is_action_just_pressed("jump") and can_jump():
		call_jump()

	# Movimento
	
	var direction := Input.get_axis("left", "right")
	if direction:
		#velocity.x = direction * speed
		if velocity.x > 0:
			last_dir = 1
		elif velocity.x < 0:
			last_dir = -1
	#else:
		#velocity.x = move_toward(velocity.x, 0, speed)
	apply_traction(delta)
	apply_friction(delta)

func apply_traction(delta):
	var traction : Vector2 = Vector2()
	traction.x += Input.get_axis("left", "right")
	velocity.x += traction.x * acceleration * delta

	pass

func apply_friction(delta):
	velocity.x -= velocity.x * friction * delta
	pass
	
func wall(delta):
	print("state wall")
	# Se soltar a tecla volta pra o jump
	
	if Input.get_axis("left","right") != last_dir or !is_on_wall_only():
		state = states.jump
		
	if Input.is_action_just_pressed("jump") and can_jump():
		velocity.x = 3000 * -Input.get_axis("left","right") 
		$Timer_wall.start(0.3)
		can_wall = false
		call_wall_jump()
	
	velocity = wall_gravity * delta

	if is_on_floor():
		state = states.move
	pass


func jump(delta):
	print("state jump")
	# Volta pra o Move
	if is_on_floor():
		state = states.move
	
	# Pulo estilo Mario, se o player sobe é uma velocidade, se ele desce é outra
	if velocity.y < 0:
		velocity += gravity * delta
	else:
		velocity += (gravity * gravity_down) * delta
		# Chama o wall state
		if Input.get_axis("left","right") == last_dir and is_on_wall_only() and can_wall:
			current_jumps += 1
			state = states.wall
			
	# Se o player solta o botao ele corta o jump
	if Input.is_action_just_released("jump"): 
		if velocity.y < -100:
			velocity.y = -100
	
	# Movimento no ar
	
	var direction := Input.get_axis("left", "right")
	if direction:
		#velocity.x = direction * speed
		if velocity.x > 0:
			last_dir = 1
		elif velocity.x < 0:
			last_dir = -1
	#else:
		#velocity.x = move_toward(velocity.x, 0, speed)
	apply_traction(delta)
	apply_friction(delta)	
	# Double jump(quando tiver)
	if Input.is_action_just_pressed("jump") and can_jump():
		call_jump()

func call_jump():
		current_jumps -= 1
		velocity.y = jump_speed
		state = states.jump

func can_jump() -> bool:
	if is_on_floor():
		current_jumps = max_jumps
	if current_jumps > 0:
		return true
	else:
		return false

func call_wall_jump():
		can_wall = false
		velocity.y = jump_speed
		velocity.x = jump_speed * -last_dir
		current_jumps -= 1
		state = states.jump


func _on_timer_wall_timeout() -> void:
	can_wall = true
	pass # Replace with function body.
