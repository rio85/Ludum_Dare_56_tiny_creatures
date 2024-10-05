extends Area2D
class_name SwitchClass


@export var target : Array[PlatformComponent]

@export var act_tiny_creature : bool = true
@export var act_player : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	
	if body is TinyCreature and act_tiny_creature:
		for t: PlatformComponent in target:
			t.activate()
			
	if body is Player and act_player:
		for t: PlatformComponent in target:
			t.activate()
	
	pass # Replace with function body.
