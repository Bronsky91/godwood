extends Node2D

onready var player_sprite = {
	'acc1': $PlayerSprites/Accessory1,
	'acc2': $PlayerSprites/Accessory2,
	'acc3': $PlayerSprites/Accessory3,
	'arms': $PlayerSprites/Arms,
	'body': $PlayerSprites/Body,
	'bota': $PlayerSprites/BottomA,
	'botb': $PlayerSprites/BottomB,
	'eyes': $PlayerSprites/Eyes,
	'haira': $PlayerSprites/HairA,
	'hairb': $PlayerSprites/HairB,
	'hairc': $PlayerSprites/HairC,
	'haird': $PlayerSprites/HairD,
	'head': $PlayerSprites/Head,
	'jaca': $PlayerSprites/JacketA,
	'jacb': $PlayerSprites/JacketB,
	'shoe': $PlayerSprites/Shoes,
	'topa': $PlayerSprites/TopA,
	'topb': $PlayerSprites/TopB
}

func _ready():
	pass

func _process(delta):
	pass

func set_sprite_texture(sprite, options):
	var texture_path = "res://Assets/Character/{gender}/{height}{weight}/{category}/{gender}_{height}{weight}_Idle{number}.png".format({
		"gender": options.gender,
		"height": options.height,
		"weight": options.weight,
		"category": options.category,
		"number": "_"+str(options.number)
	})
	sprite.set_texture(load(texture_path))