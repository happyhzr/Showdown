extends Node2D

var world=null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_world()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func restart():
	world.queue_free()
	create_world()

func create_world():
	var world_blueprint:PackedScene=load("res://world.tscn")
	world=world_blueprint.instantiate()
	world.restart_requested.connect(restart)
	add_child(world)
