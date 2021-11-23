extends RigidBody

var fmove : float = 0.0
var smove : float = 0.0

var motion : Vector2

var wishdir : Vector3

func _input(event):
	fmove = Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward")
	smove = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")


func _integrate_forces(state):
	state.add_force(wishdir.normalized() * 60, Vector3.ZERO)
	
	var velocity = linear_velocity
	var drag_force = 2.0 * -velocity.normalized() * velocity.length_squared()
	state.add_central_force(Vector3(drag_force.x, 0, drag_force.z))

func _process(delta):
	
	$UI/Label.text = String(linear_velocity.round())
	motion = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward"))
	wishdir = (global_transform.basis.x * smove + -global_transform.basis.z * fmove).normalized()
