extends CharacterBody2D
class_name TinyCreature

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var direction : int = 1

enum states {idle, move}
var state = states.idle


func _physics_process(delta: float) -> void:

	match state:
		states.move:
			move(delta)
		states.idle:
			idle()

	# Gravidade
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
	
	if Input.is_action_just_pressed("dash"):
		if state == states.idle:
			change_to_move()
		elif  state == states.move:
			change_to_idle()



func move(delta):
	velocity.x = direction * SPEED


func idle():
	velocity.x = move_toward(velocity.x, 0, SPEED)

	
func change_to_idle():
	$AnimatedSprite2D.play("idle")
	state = states.idle
	pass
	
func change_to_move():
	$AnimatedSprite2D.play("walk")
	state = states.move
	pass
