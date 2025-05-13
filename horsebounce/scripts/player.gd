extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const death_floor = 250

var is_jumping = false

#custom signal for when you die
signal dead

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x < 0:
		$Sprite2D.flip_h = true
	elif velocity.x > 0:
		$Sprite2D.flip_h = false

	move_and_slide()
	
	for index in get_slide_collision_count():
		var collision = get_slide_collision(index)
		if collision.get_collider().is_in_group("BadThings"):
			print("I'm Dead")
			emit_signal("dead")
			self.queue_free()
			
	if self.global_position.y > death_floor :
		print("I fell")
		emit_signal("dead")
		self.queue_free()
	
	if is_on_floor():
		stop_flipping()
	
	if is_jumping:
		do_a_flip(delta)

func do_a_flip(delta):
	if velocity.x < 0:
		$Sprite2D.rotate(delta * -10)
	elif velocity.x > 0:
		$Sprite2D.rotate(delta * 10)
	
func stop_flipping():
	$Sprite2D.rotation_degrees = 0
