class_name Bullet
extends CharacterBody2D

@onready var player_hitbox = $playerHitbox # i think this needs to be changed

@export var initial_speed = 240
@export var target_speed = 240 
@export var acceleration = 0
@export var lifespan = 1

var speed = initial_speed
var direction = Vector2.RIGHT

func _ready():
	direction = Vector2.RIGHT.rotated(global_rotation)
	
	if player_hitbox:
		player_hitbox.area_entered.connect(_on_hitbox_area_entered)
	
	await get_tree().create_timer(lifespan).timeout
	await _before_lifespan_expired()
	queue_free()

func _physics_process(delta):
	speed = lerp(speed, target_speed, acceleration * delta)
	velocity = direction * speed * delta
	
	var collision = move_and_collide(velocity)
	if collision:
		queue_free()

func _before_lifespan_expired():
	pass


func _on_hitbox_area_entered(area: Area2D):
	if area.has_method("damage"):
		var attack = Attack.new()
		attack.attack_damage = attack damage # rewatch video onb how he assigns damage, this may be a nested mess, i shoudl go to sleep[
