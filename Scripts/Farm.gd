extends Node2D

onready var tile_map: TileMap = $TileSheet/GroundTiles
onready var grid_helper = get_node('../GridHelper')

var player: KinematicBody2D

var tile_pos_infront_of_player

func _ready():
	pass
	
func set_player(new_player):
	player = new_player

func _physics_process(delta):
	if player:
		var player_pos = player.global_position
		var tile_pos_player_is_on = tile_map.world_to_map(player_pos) + Vector2(0, 2)
		# Use face direction to determine where to put grid helper
		tile_pos_infront_of_player = tile_pos_player_is_on + player.last_direction
		grid_helper.global_position = tile_pos_infront_of_player * 16 # tile size

func _input(event):
	if event.is_action_pressed('click'):
		print(tile_pos_infront_of_player)
		print(tile_map.get_cell(tile_pos_infront_of_player.x, tile_pos_infront_of_player.y))
		if tile_map.get_cellv(tile_pos_infront_of_player) == c.DIRT_ID:
			tile_map.set_cellv(tile_pos_infront_of_player, tile_map.tile_set.find_tile_by_name(c.TILLED_DIRT_NAME))
			
