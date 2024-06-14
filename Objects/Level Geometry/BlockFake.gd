extends Sprite2D

@export var alpha = -.5
@export var vanish_speed = .01

@export var vanish_on_start = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if vanish_on_start && alpha < 2 && alpha > -1:
		modulate.a = 1 - alpha
		alpha = alpha + vanish_speed
		#print_debug("ALPHA ", alpha)
	pass
