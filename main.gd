# main.gd
extends CharacterBody3D

var speed = 6.0
var mouse_sensitivity = 0.003
var camera_3rd_person = true

@onready var camera = $Camera3D

func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
    if Input.is_action_just_pressed("ui_cancel"):
        get_tree().quit()
    if Input.is_action_just_pressed("toggle_view"):
        camera_3rd_person = !camera_3rd_person
        _update_camera_view()

func _physics_process(delta):
    var input_dir = Vector2.ZERO
    input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    input_dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    velocity.x = direction.x * speed
    velocity.z = direction.z * speed
    move_and_slide()

func _update_camera_view():
    if camera_3rd_person:
        camera.translation = Vector3(0, 1.8, -4)
    else:
        camera.translation = Vector3(0, 1.7, 0.1)
