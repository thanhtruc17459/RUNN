extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -600.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("Container/AnimatedSprite2D")

@onready var container = get_node("Container")

func _physics_process(delta: float) -> void:
		
	# rơi do trong luc
	if not is_on_floor():
		velocity += get_gravity() * delta

	# xử lý nhảy
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# xử lý di chuyển trái phải
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction == 1 or direction == -1:
		velocity.x = direction * SPEED
		container.scale.x=-direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# xử lý chuyển động
	if not is_on_floor():
		if velocity.y < 0:
			anim.play("jump")
	else:
		if direction == 1 or direction == -1:
			if abs(velocity.x) > 150:
				anim.play("Run")
			else:
				anim.play("walk")
		else:
			anim.play("idle")


	move_and_slide()
	
	
