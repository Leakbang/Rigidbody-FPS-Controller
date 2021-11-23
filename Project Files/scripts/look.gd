extends Camera

onready var player = get_parent()

var mouse_move : Vector2 = Vector2.ZERO
var mouse_rotation_x : float = 0.0
var mouse_sensitivity : float = 0.1

var y_offset : float = 1.25   

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called when the node enters the scene tree for the first time.
func _input(event):
	if event is InputEventMouseMotion:
		mouse_move = event.relative * 0.1
		mouse_rotation_x -= event.relative.y * mouse_sensitivity
		mouse_rotation_x = clamp(mouse_rotation_x, -90, 90)
		player.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		


func _physics_process(delta):
	# Set points of origin
	rotation_degrees = Vector3(mouse_rotation_x, 0, 0)
	transform.origin = Vector3(0, y_offset, 0)

