extends AnimatableBody2D
class_name PlatformComponent

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var activated : bool = false
@export var activate_on_anim_finish : bool = false
@export var target : Array[TinyCreature]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and !activated:
		activate()
		activated = true
	pass

func activate():
	animation_player.play("activate")
	#var tw = get_tree().create_tween()
	#tw.tween_property(self, "rotation_degrees", 45.0, 1).set_ease(Tween.EASE_OUT)
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if activate_on_anim_finish:
		pass
	pass # Replace with function body.
