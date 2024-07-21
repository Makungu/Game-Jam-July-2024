class_name Player
extends CharacterBody2D

@export var max_health: int = 300
@export var max_health_potions: int = 2
@export var max_light: float = 100
@export var max_speed: float = 300.0
@export var max_accelaration: float = 500.0
@export var max_velocity: float = 100.0

var health: int = max_health
var health_potions: int = max_health_potions
var light: float = max_light 
var speed: float = 0
var accelaration: float = 10
var direction: Vector2 = Vector2.ZERO
var hit_box: PackedScene = preload("res://shared_components/hit_box.tscn")

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D

signal health_changed(health)
signal health_depleted(health)
signal initialise_health(max_health)
signal light_changed(light)
signal light_depleted(light)
signal initialise_light(max_light)

func _ready():
	emit_signal("initialise_health", max_health)
	emit_signal("initialise_light", max_light)
	animation_tree.active = true

func _process(delta):
	if light > 0:
		use_light(0.01)
	if light == 0:
		take_damage(1)
	move_and_slide()
	
func take_damage(damage: int):
	health -= damage
	health = max(0, health)
	emit_signal("health_changed", health)

func use_light(light_used: float):
	light -= light_used
	light = max(0, light)
	emit_signal("light_changed", light)
	
func heal(healing: int):
	health += healing
	health = max(health, max_health)
	emit_signal("health_changed", health)
	
func gain_light(light_gained: float):
	light += light_gained
	light = max(light, max_light)
	emit_signal("light_changed", light)
