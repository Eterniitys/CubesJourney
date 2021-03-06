extends Node2D

var move_vec

export(int) var duration = 5
export var transition = 0
export var t_ease = 1
export var continue_when_started = true
export var use_button = false

export(int) var NB_CYCLE = 1
var cmpt
var locked = false

func _ready():
	move_vec = $pos_1.position - $platform.position
	cmpt = NB_CYCLE*2
	if (!use_button):
		move()

func move():
	$Tween.interpolate_property(
		$platform,
		"position",
		$platform.position,
		$platform.position + move_vec,
		duration,
		transition,
		t_ease
	)
	$Tween.start()

# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_Tween_completed(object, key):
	move_vec *= -1
	if continue_when_started or !use_button:
		move()
	elif (cmpt > 0):
		cmpt -= 1
		move()
	else:
		locked = false
		$button/Sprite.frame = 0

# warning-ignore:unused_argument
func _on_button_body_entered(body):
	if !locked:
		locked = true
		cmpt = NB_CYCLE*2-1
		$button/Sprite.frame = 1
		move()
