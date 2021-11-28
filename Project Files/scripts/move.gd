extends RigidBody

var fmove : float = 0.0
var smove : float = 0.0

var wishdir : Vector3

var forward : Vector3
var left : Vector3

func _input(event):
	fmove = Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward")
	smove = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")


func _integrate_forces(state):
	forward = $Camera.forward
	left = $Camera.left
	
	$UI/Label.text = String(linear_velocity.round())
	wishdir = forward * fmove + left * smove
	
	state.add_central_force(Vector3(wishdir.x, 0, wishdir.z) * 60)
	
	var velocity = linear_velocity
	var drag_force = 2.0 * -velocity.normalized() * velocity.length_squared()
	
	state.add_central_force(Vector3(drag_force.x, 0, drag_force.z))
