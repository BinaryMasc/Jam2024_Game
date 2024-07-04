extends Area2D

class_name Cat

var animation: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	animation = $AnimatedSprite2D
	animation.hide()
	animation.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
