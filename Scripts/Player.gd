extends KinematicBody2D

export (int) var speed = 100

onready var animation_player = get_node("PlayerSprites/AnimationPlayer")
onready var nav = get_node('../..')
onready var farm = get_node('../Farm')
onready var positions = get_node('../Farm/Positions')

var velocity = Vector2()
var destination: Vector2
var path: PoolVector2Array
var stopped: bool = false
var last_direction: Vector2 = Vector2.DOWN
var current_pos: Position2D

var animation_directions = {
	Vector2.RIGHT: "right",
	Vector2.RIGHT + Vector2.DOWN: "front",
	Vector2.DOWN: "front",
	Vector2.LEFT + Vector2.DOWN: "front",
	Vector2.LEFT: "left",
	Vector2.LEFT + Vector2.UP: "back",
	Vector2.UP: "back",
	Vector2.RIGHT + Vector2.UP: "back",
	Vector2(0, 0): "front"
}

signal direction_change

func _ready():
	connect("direction_change", self, '_on_direction_change')
	move_position()

func get_input():
	## Not being used in Dress Up
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	if velocity.round() != last_direction:
		emit_signal('direction_change', velocity.round())
	velocity = velocity.normalized() * speed
	
	
func _physics_process(delta):
		# Calculate the movement distance for this frame
	var distance_to_walk = speed * delta
	# Move the character along the path until he has run out of movement or the path ends
	while distance_to_walk > 0 and path.size() > 0:
		stopped = false
		emit_signal("direction_change", position.direction_to(path[0]).round ())
		var distance_to_next_point = position.distance_to(path[0])
		if distance_to_walk <= distance_to_next_point:
			# The character does not have enough movement left to get to the next point.
			position += position.direction_to(path[0]) * distance_to_walk
			last_direction = position.direction_to(path[0]).round ()
		else:
			# The character get to the next point
			position = path[0]
			path.remove(0)
		# Update the distance to walk
		distance_to_walk -= distance_to_next_point
	
	if path.size() == 0 or speed == 0 and not stopped:
		play_stopped_animation()
		stopped = true

func _on_direction_change(new_direction):
	if new_direction != last_direction:
		var animation_direction = animation_directions[new_direction]
		animation_player.play("walk_"+animation_direction)
	if stopped:
		play_stopped_animation()

func play_stopped_animation():
	var animation_direction = animation_directions[last_direction]
	animation_player.play("idle_"+animation_direction)


func _on_ChangePosTimer_timeout():
	move_position()
	print(farm.available_positions)


func get_random_position():
	var positions = farm.available_positions
	if positions.size() <= 1: # No available in positions to move to in this room
		return
	randomize()
	var rand_pos = randi() % positions.size()
	return positions[rand_pos]
	
func move_position():
	var room_pos = get_random_position()
	if not room_pos:
		# No available positions in the farm, character stays still
		return 
	farm.free_position(current_pos)
	current_pos = farm.take_position(room_pos)
	path = nav.get_simple_path(position, room_pos.global_position)
