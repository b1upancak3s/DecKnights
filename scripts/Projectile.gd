extends Area2D

var direction : Vector2 = Vector2.RIGHT
var damage : float = 1

# function to set direction and frame
func set_direction(flip_direction, frame):
	$Sprite2D.flip_h = flip_direction
	$Sprite2D.frame = frame
	if flip_direction == false:
		direction = Vector2.RIGHT
	else:
		direction = Vector2.LEFT
		
# function to move projectiles
func _physics_process(delta):
	position += direction * 200 * delta

func _on_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
