extends Node2D

# Reference to the projectile scene
var projectile_scene = preload("res://scenes/subscenes/projectile.tscn")

# Speed at which the projectile will move
var projectile_speed = 200

# Function to instantiate and set the velocity of the projectile
func shoot(velocity: Vector2):
	var new_projectile = projectile_scene.instance()
	
	# Set the projectile's initial position
	new_projectile.position = self.global_position
	
	# Set the projectile's velocity
	new_projectile.set_linear_velocity(velocity.normalized() * projectile_speed)
	
	# Add the projectile to the scene
	get_parent().add_child(new_projectile)
