class_name Enemy
extends CharacterBody2D

@export var max_health: int = 300
@export var speed: float = 25.0
@export var accelaration: float = 500.0
@export var max_velocity: float = 100.0

var health: int = max_health 
var direction: Vector2 = Vector2.ZERO
var hit_box: PackedScene = preload("res://shared/hit_box.tscn")

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	animation_tree.active = true

func _process(delta):
	if direction.x < 0:
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false
		
	if health == 0:
		pass
		# death()
		
	move_and_slide()
	
func take_damage(damage: int):
	health -= damage
	health = max(0, health)
	emit_signal("health_changed", health)
	
func heal(healing: int):
	health += healing
	health = max(health, max_health)
	emit_signal("health_changed", health)
	
func death():
	velocity = Vector2.ZERO
	animation_tree.set("parameters/conditions/is_dead", true)
