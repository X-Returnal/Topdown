extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$health.value = $"..".health
	$Time.text = str(global.current_time)
	$Score.text =str(global.current_score)
	$LevelScore.text = str(global.level_score)
	$Chalenge.text = $"../..".current_challenge
	if global.on_run:
		if global.current_time < 0:
			global.end_run()
		global.current_time -= 1
