extends CanvasLayer

@export var deathScreen: ColorRect

func toggle_visible(object):
	object.visible = !object.visible

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_dead():
	print("dead")
