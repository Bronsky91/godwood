extends Node2D

onready var tile_map: TileMap = $TileSheet/GroundTiles
onready var grid_helper = get_node('../YSort/GridHelper')
onready var ysort = get_node('../YSort')

var player: KinematicBody2D

var tile_pos_infront_of_player


# TMP TEST
var crop_data = {
	"pk": 1,
	"object_name": "Turnip",
	"phase_days": [1, 1, 1, 1, 1, 1, INF],
	"current_phase": 0,
	"day_of_current_phase": 0,
	"crop_age": 0
	}

func _ready():
	t.connect("new_day_start", self, 'refresh_tiles')
	
func set_player(new_player):
	player = new_player

func _physics_process(delta):
	if player:
		var player_pos = player.global_position
		var tile_pos_player_is_on = tile_map.world_to_map(player_pos) + Vector2(0, 1)
		# Use face direction to determine where to put grid helper
		tile_pos_infront_of_player = tile_pos_player_is_on + player.last_direction
		grid_helper.global_position = tile_pos_infront_of_player * 16 # tile size

func _input(event):
	if event.is_action_pressed('hoe'):
		if tile_map.get_cellv(tile_pos_infront_of_player) == c.DIRT_ID:
			tile_map.set_cellv(tile_pos_infront_of_player, tile_map.tile_set.find_tile_by_name(c.TILLED_DIRT_NAME))
	if event.is_action_pressed("water"):
		if tile_map.get_cellv(tile_pos_infront_of_player) == c.TILLED_DIRT_ID:
			tile_map.set_cellv(tile_pos_infront_of_player, tile_map.tile_set.find_tile_by_name(c.WET_DIRT_NAME))
	if event.is_action_pressed('plant'):
		if tile_map.get_cellv(tile_pos_infront_of_player) == c.TILLED_DIRT_ID:
			var crop_path = "res://Crops/Turnip/Turnip.tscn"
			var crop = load(crop_path).instance()
			crop.initialize(crop_data)
			crop.global_position = tile_pos_infront_of_player * 16
			crop.farm_map = tile_map
			add_child(crop)

func refresh_tiles():
	var wet_dirts = tile_map.get_used_cells_by_id(c.WET_DIRT_ID)
	for tile_pos in wet_dirts:
		tile_map.set_cellv(tile_pos, tile_map.tile_set.find_tile_by_name(c.TILLED_DIRT_NAME))
