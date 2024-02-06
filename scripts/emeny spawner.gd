extends Node2D

@export
var progress_speed:float = 15
@export
var unit_spawn:PackedScene
@export
var limit_spawn:int = 3
@export
var health:int = 5

var progress:float = 0

var spawned:int = 0
func _ready():
	add_to_group("mobs")
	add_to_group("spawner")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <0.01:
		global.level_score += 500
		queue_free()
	
	if spawned < limit_spawn or limit_spawn < 0:
		progress += progress_speed*delta
		if progress > 100:
			$spawn.play(0)
			var b = unit_spawn.instantiate()
			owner.add_child(b)
			b.transform = $Sprite2D.global_transform
			spawned+=1
			progress = 0
	$ProgressBar.value = progress
func damage(amount):
	$hit.play(0)
	health -= amount
func powerplay():
	health = 99999
	limit_spawn = -1
	progress_speed = 100
	
