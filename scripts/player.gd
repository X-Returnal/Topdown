extends CharacterBody2D
@export var Bullet : PackedScene

func _ready():
	add_to_group("player")
	randomize()
	
@export
var health = 3 #how many damage you can tank

@export
var speed = 400  # speed in ... speed units, i guess

@export
var progress_speed:float = 250

@export
var burst_mode = false #modifer for bullets per shot // adds a small delay

@export
var murder = false

@export
var burst_speed = 80


@export
var bullets_per_shot = 1

@export
var bullet_spread:float = 0.1

var refire:bool = false

var progress:float = 101

@export
var reset_progress = 185 #what progress is set to when letting go of click

var invultime:int = 120

var j = bullets_per_shot # quick workaround for burst 

func _physics_process(delta):
	invultime -= 1
	
	var direction = Input.get_vector("left", "right", "up", "down") *30
	
	$TankBeigeOutline.look_at(direction+position)
	if direction != Vector2(0,0):
		$TankBeigeOutline.rotation_degrees += -90
	$BarrelBeigeOutline.look_at(get_global_mouse_position())
	$BarrelBeigeOutline.rotation_degrees += -90
	velocity = direction * speed * delta
	
	if health <0.01:
		global.end_run()
		queue_free()
	
	if !Input.is_action_pressed("click"):
		progress = reset_progress
		refire = false
	
	if Input.is_action_pressed("click"):
		progress += progress_speed*delta
		if progress > 100:
			var i = bullets_per_shot
			while i >0 and !burst_mode:
				i-=1 
				shoot()
				refire = true
				progress = 0
			if burst_mode:
				
				if murder:
					while i >0:
						refire = true
						i-=1 
						shoot()
						refire = false
				shoot()
				
				if j > 0:
					j -= 1
					progress = burst_speed
				else:
					j = bullets_per_shot
					progress = 0
	
	
	move_and_slide()
func shoot():
	$shoot.play(0)
	var b = Bullet.instantiate()
	b.bullet_team = 1
	
	owner.add_child(b)
	var deviation_angle = PI * bullet_spread
	b.transform = $BarrelBeigeOutline/source.global_transform
	if refire:
	
		b.rotation += randf_range(-deviation_angle, deviation_angle)

func damage(amount):
	if invultime > 0:
		return false
	else:
		$hurt.play(0)
		health -= amount
		invultime = 120
		return true
