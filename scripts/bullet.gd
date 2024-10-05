extends Area2D
class_name Projectile

@export var speed : float = 2000.0
@export var lifetime : float = 3.0
@export var damage : int = 3
@export var knockback : float = 5

@onready var timer_destroy_self: Timer = $Timer_DestroySelf

var direction : Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	top_level = true
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	move(delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func move(delta):
	position += direction * speed * delta
	
func shoot(dir) -> Vector2:
	timer_destroy_self.start(lifetime)
	direction = dir
	return global_position


func _on_timer_destroy_self_timeout() -> void:
	queue_free()
	pass # Replace with function body.
