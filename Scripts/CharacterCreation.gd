extends Node2D

onready var player_sprite = {
	'Accessory 1': $PlayerSprites/Accessory1,
	'Accessory 2': $PlayerSprites/Accessory2,
	'Accessory 3': $PlayerSprites/Accessory3,
	'Arms': $PlayerSprites/Arms,
	'Body': $PlayerSprites/Body,
	'Bottom A': $PlayerSprites/BottomA,
	'Bottom B': $PlayerSprites/BottomB,
	'Eyes': $PlayerSprites/Eyes,
	'Hair A': $PlayerSprites/HairA,
	'Hair B': $PlayerSprites/HairB,
	'Hair C': $PlayerSprites/HairC,
	'Hair D': $PlayerSprites/HairD,
	'Head': $PlayerSprites/Head,
	'Jacket A': $PlayerSprites/JacketA,
	'Jacket B': $PlayerSprites/JacketB,
	'Shoes': $PlayerSprites/Shoes,
	'Top A': $PlayerSprites/TopA,
	'Top B': $PlayerSprites/TopB
}

var player_name: String
var farm_name: String
var gender: String
var body: String

var current_animation = 0

func _ready():
	create_random_character()
	$PlayerSprites/AnimationPlayer.play("idle_front")
	
func _process(delta):
	pass

func set_sprite_texture(sprite: Sprite, options: Dictionary):
	var texture_path = "res://Assets/Character/{gender}/{body}/{sprite_name}/{gender}_{body}_Idle{number}.png".format({
		"gender": options.gender,
		"body": options.body,
		"sprite_name": options.sprite_name,
		"number": "_"+str(options.number)
	})
	sprite.set_texture(load(texture_path))
	
func random_asset(folder: String):
	var files = g.files_in_dir(folder, "Idle")
	randomize()
	var random_index = randi() % len(files)
	return folder+"/"+files[random_index]
	
func create_random_character():
	var folder_path = "res://Assets/Character/{gender}/{body}".format({"gender": "Female", "body": "AvThn"})
	var folders = g.files_in_dir(folder_path)
	for folder in folders:
		var random_asset = random_asset(folder_path+"/"+folder)
		if "000" in random_asset: # Prevent some empty sprite sheets
			if folder == "Hair A" and "Hair" in random_asset: # If main hair is bald, leave rest of hair
				continue
			if "Top" in folder or "Bottom" or folder: # If no top or no bottom was returned, dont set the texture
				continue
		player_sprite[folder].set_texture(load(random_asset))

func _on_GenderButton_button_up(_gender):
	gender = _gender
	set_sprite_texture(player_sprite.body, {"gender": gender, "body": body, "sprite_name": "Body", "number": ""})

func _on_Random_button_up():
	create_random_character()


func _on_Turn_button_up(direction):
	var animations = ['idle_front', 'idle_right', 'idle_back', 'idle_left']
	current_animation += direction
	if current_animation == 4 or current_animation == -4:
		current_animation = 0
	$PlayerSprites/AnimationPlayer.play(animations[current_animation])
	
