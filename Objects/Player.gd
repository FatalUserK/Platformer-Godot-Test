extends CharacterBody2D

@export var disable_player_frames = 0

@export var respawn_point = Vector2()

var SPACEBAR_HELD = 0

const SPEED = 400.0
const JUMP_VELOCITY = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print_debug("AREA COLLISION DETECTED!!!!!!!!!!!!!!!")
	if area.is_in_group("magma"):
		perish()
	else: if area.is_in_group("LevelFinish"):
		get_tree().change_scene_to_file("res://MainMenu.tscn")
	else: if area.is_in_group("Checkpoint"):
		respawn_point = position
	pass

func perish(type = "magma"):
	if type == "magma":
		pass
	position = respawn_point
	pass

func _ready():
	respawn_point = position
	pass


func _physics_process(delta):
	if disable_player_frames == -1:
		return
	if disable_player_frames > 0:
		disable_player_frames = disable_player_frames - 1
		print_debug("DISABLED PLAYER FRAMES REMAINING: ", disable_player_frames)
		return
	
	# Add the gravity.
	

	if Input.is_action_just_released("JUMP") && velocity.y < 0:
		velocity.y = velocity.y * clamp(.8 + SPACEBAR_HELD / 100, .2, 1)
	
	if not is_on_floor():
		
		if not Input.is_action_pressed("JUMP"):
			#velocity.y -= velocity.y / 10
			SPACEBAR_HELD += -30
		else:
			SPACEBAR_HELD += 5
			
		clamp(SPACEBAR_HELD, -150, 100)
		velocity.y += (gravity - SPACEBAR_HELD) * delta
		clamp(velocity.y, -200, 200)
		

	# Handle jump.
	if Input.is_action_just_pressed("JUMP") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		SPACEBAR_HELD = 0
		print_debug("PLAYER JUMPED")


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("LEFT", "RIGHT")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


