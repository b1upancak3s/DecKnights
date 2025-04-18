extends CharacterBody2D

const speed = 30

@export var player : Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var sprite = $Sprite2D
@onready var animation = $AnimationPlayer

func _physics_process(_delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	
	if velocity.x > 0:
		animation.play("run")
		if velocity.x < 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
	move_and_slide()
	
func makepath() -> void:
	nav_agent.target_position = player.global_position



func _on_timer_timeout():
	makepath()
