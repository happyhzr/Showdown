extends Node2D

signal restart_requested

var is_ready_to_restart=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start(randf_range(3,7))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_ready_to_restart and Input.is_action_just_pressed("restart"):
		restart_requested.emit()

func resolve_duel(action):
	if action=="p1_shoot":
		$Cowboy2.kill()
	elif action=="p2_shoot":
		$Cowboy.kill()

func start_duel():
	$Cowboy.is_allowed_to_shoot=true
	$Cowboy2.is_allowed_to_shoot=true
	$Plank/Label.text="SHOOT!"
	$Plank/Label.modulate=Color.CHARTREUSE

func game_over():
	$EndMusicPlayer.play()
	$AnimationPlayer.play("restart")
	is_ready_to_restart=true
