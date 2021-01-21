extends KinematicBody2D

export (int) var speed = 100

onready var animation_player = get_node("PlayerSprites/AnimationPlayer")
onready var farm = get_node('../Farm')

var velocity = Vector2()
var stopped: bool = false
var last_direction: Vector2 = Vector2.DOWN
var p_name: String

var animation_directions = {
	Vector2.RIGHT: "right",
	Vector2.RIGHT + Vector2.DOWN: "front",
	Vector2.DOWN: "front",
	Vector2.LEFT + Vector2.DOWN: "front",
	Vector2.LEFT: "left",
	Vector2.LEFT + Vector2.UP: "back",
	Vector2.UP: "back",
	Vector2.RIGHT + Vector2.UP: "back",
}

signal direction_change

func _ready():
	connect("direction_change", self, '_on_direction_change')

func get_input():
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
	get_input()
	velocity = move_and_slide(velocity)


func _on_direction_change(new_direction):
	if new_direction == Vector2(0, 0):
		play_stopped_animation()
	elif new_direction != last_direction:
		var animation_direction = animation_directions[new_direction]
		animation_player.play("walk_"+animation_direction)
		last_direction = new_direction

func play_stopped_animation():
	var animation_direction = animation_directions[last_direction]
	animation_player.play("idle_"+animation_direction)
