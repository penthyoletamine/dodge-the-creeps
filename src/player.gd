class_name Player
extends Area2D


signal hit

export(int) var speed = 400
var screen_size
var velocity


func _ready():
	hide()
	screen_size = get_viewport_rect().size


func _process(delta):
	velocity = Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position = Vector2(clamp(position.x, 0, screen_size.x), clamp(position.y, 0, screen_size.y))
	
	if velocity.x > 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = true
	
	if velocity.y < 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = false
	elif velocity.y > 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = true


func _on_Player_body_entered(_body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
