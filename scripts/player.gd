extends CharacterBody2D


const SPEED = 200.0
var last_direction = Vector2.RIGHT

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	process_movement()
	process_anim()
	move_and_slide()

func process_movement() -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		last_direction = direction
	else:
		velocity = Vector2.ZERO

func process_anim() -> void:
	if velocity != Vector2.ZERO:
		play_anim("walk", last_direction)
	else:
		play_anim("idle", last_direction)

func play_anim(prefix: String, dir: Vector2) -> void:
	if dir.x != 0:
		anim_sprite.flip_h = dir.x < 0
		anim_sprite.play(prefix + "_right")
	elif dir.y > 0:
		anim_sprite.play(prefix + "_down")
	elif dir.y < 0:
		anim_sprite.play(prefix + "_up")
