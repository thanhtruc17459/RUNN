extends CharacterBody2D


const SPEED = 2800.0
const JUMP_VELOCITY = -400.0

#get the gravity from the project settings to be synced with RigidBody node
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("container/AnimatedSprite2D")
@onready var  container = get_node("container")
@onready var player=get_node("../player")

var player_in_sight



func _ready():
	anim.play("idle")
func _physics_process(delta):
	if player_in_sight:
		velocity=(player.position-self.position).normalized()*SPEED*delta
		if self.position.x > player.position.x:
			container.scale.x=1
		elif self.position.x<player.position.x:
			container.scale.x=-1
		move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		get_tree().change_scene_to_file("res://world.tscn")


func _on_player_in_sight(body: Node2D) -> void:
	if body.name == "player":
		player_in_sight = true
