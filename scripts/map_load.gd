extends Node2D

@export
var current_challenge = ""
func _ready():
	
	match randi_range(0,5):
		0:
			current_challenge = "Kill All!"
		1:
			current_challenge = "Survive!"
		2:
			if global.map != 0:
				current_challenge = "Get Score!"
			else:
				current_challenge = "Kill All!"
		_:
			current_challenge = "Survive!"
func _process(_delta):
	match current_challenge:
		"Kill All!":
			
			if $enemeys.get_child_count() < 1:
				current_challenge ="Level Cleared!"
				
		"Survive!":
			get_tree().call_group("spawner","powerplay")
			await get_tree().create_timer(10).timeout
			get_tree().call_group("mobs","damage",999999)
			current_challenge ="Level Cleared!"
			
		"Level Cleared!":
			await get_tree().create_timer(.25).timeout
			print("New level!")
			load_new_level()
func load_new_level():
	global.current_score += global.level_score
	global.cleared_floors += 1
	match randi_range(0,5):
		0:
			global.map = 0
			get_tree().change_scene_to_file("res://scenes/lvl_0.tscn")
#		1:
#			get_tree().change_scene_to_file("res://scenes/lvl_1.tscn")
#		2:
#			get_tree().change_scene_to_file("res://scenes/lvl_2.tscn")
#		3:
#			get_tree().change_scene_to_file("res://scenes/lvl_3.tscn")
#		4:
#			get_tree().change_scene_to_file("res://scenes/lvl_4.tscn")
#		5:
#			get_tree().change_scene_to_file("res://scenes/lvl_5.tscn")
func level_clear():
	pass
	
