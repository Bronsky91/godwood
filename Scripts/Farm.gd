extends Node2D

onready var tile_map = $TileSheet/GroundTiles
onready var tile_hover_node = $TileHover

var cursor_cell
var mouse_pos

var cursor_tile_x
var cursor_tile_y
var cursor_tile_pos

var previous_tile_name


func _ready():
	pass

func _process(delta):
	mouse_pos = get_local_mouse_position()
	
	var loc = tile_map.world_to_map(mouse_pos)
	var cell = tile_map.get_cell(loc.x,loc.y)
	
	var tile_name = tile_map.tile_set.tile_get_name(cell)
	if tile_name == "dirt":
		tile_map.tile_set.tile_set_modulate(cell, Color.aqua)
		tile_hover_node.show()
		tile_hover_node.position = mouse_pos.snapped(Vector2(16,16))
	else:
		tile_hover_node.hide()
		
