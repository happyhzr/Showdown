extends Node2D

enum State{
	Waiting,
	Shooting,
	Dying,
	Fumbling,
}

signal shot_gun(action)
signal game_over

@export var action_name="p1_shoot"

var current_state=State.Waiting
var is_allowed_to_shoot=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_state==State.Waiting and Input.is_action_just_pressed(action_name):
		if is_allowed_to_shoot:
			shoot()
		else:
			fumble()
func kill():
	current_state=State.Dying
	$AnimationPlayer.play("die")
	$KeyboardSprite.visible=false
	
func shoot():
	current_state=State.Shooting
	$AnimationPlayer.play("shoot")
	$KeyboardSprite.visible=false
	$AudioStreamPlayer.play()
	shot_gun.emit(action_name)

func fumble():
	current_state=State.Fumbling
	$AnimationPlayer.play("fumble")

func wait():
	current_state=State.Waiting
	$AnimationPlayer.play("idle")

func holster():
	$AnimationPlayer.play("holster")
	game_over.emit()
	$WinLabel.visible=true
