extends Node2D

const player_scene = preload("res://Scenes/Player.tscn")

onready var farm = get_node("Navigation2D/Farm")
onready var ysort = get_node("Navigation2D/YSort")

var player_array: Array

var player_node: KinematicBody2D

func _ready():
	player_array = g.load_dress_up_players()
	for player in player_array:
		var new_player = player_scene.instance()
		if player.name == "Player":
			new_player.p_name = player.name
			g.load_player(new_player.get_node("PlayerSprites/SpriteHolder"), player.name)
			new_player.position = farm.get_node("StartPosition").global_position
			ysort.add_child(new_player)
			farm.set_player(new_player)
			player_node = new_player
		else:
			new_player.queue_free()

func _process(delta):
	$UI/TimeLabel.text = "Year: {year} \nMonth: {month}\nSeason: {season} \nDay: {day} \nHour: {hour} {meridiem} \nMinute: {min}".format({"year":t.year, "month": t.month, "season": t.season, "day": t.day, "hour": t.hour_show, "meridiem": t.meridiem, "min": t.minute_interval})
