extends Node2D
@onready var pause_menu = $PauseMenu
@onready var intro_message = $RichTextLabel
var greencorp_logo = "res://art/sprites/green_corp_logo.PNG"
var inputted_numbers = ""
var code_breaking_active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu.hide()
	start_intro_window()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		print_debug("Cancel pressed")
		_on_cancel_pressed()
	elif event.is_action_pressed("escape"):
		pause_menu.show()
		
	if code_breaking_active:
		if Input.is_action_just_pressed("0"):
			add_to_inputted_numbers(0)
		elif Input.is_action_just_pressed("1"):
			add_to_inputted_numbers(1)
		elif Input.is_action_just_pressed("2"):
			add_to_inputted_numbers(2)
		elif Input.is_action_just_pressed("3"):
			add_to_inputted_numbers(3)
		elif Input.is_action_just_pressed("4"):
			add_to_inputted_numbers(4)
		elif Input.is_action_just_pressed("5"):
			add_to_inputted_numbers(5)
		elif Input.is_action_just_pressed("6"):
			add_to_inputted_numbers(6)
		elif Input.is_action_just_pressed("7"):
			add_to_inputted_numbers(7)
		elif Input.is_action_just_pressed("8"):
			add_to_inputted_numbers(8)
		elif Input.is_action_just_pressed("9"):
			add_to_inputted_numbers(9)
		elif Input.is_action_just_pressed("enter"):
			try_against_correct_passcode()
			reset_inputs()
	
func _on_cancel_pressed():
	go_up_the_tree()

func go_up_the_tree():
	print_debug("Going up the tree")

func _on_screen_area_mouse_entered() -> void:
	print_debug("Mouse on screen")

func start_intro_window():
	start_booting_text()
	await get_tree().create_timer(3).timeout
	$BootingText.queue_free()
	show_greencorp_logo()
	show_login_text()

func show_greencorp_logo():
	var logo_sprite = Sprite2D.new()
	logo_sprite.texture = load(greencorp_logo)
	logo_sprite.position.x = get_viewport().size.x / 2
	logo_sprite.position.y = get_viewport().size.y / 2
	add_child(logo_sprite)

func start_booting_text():
	var i = 0
	while i <= 3:
		$BootingText.set_visible_characters(7)
		await get_tree().create_timer(0.15).timeout
		$BootingText.set_visible_characters(9)
		await get_tree().create_timer(0.15).timeout
		$BootingText.set_visible_characters(11)
		await get_tree().create_timer(0.15).timeout
		$BootingText.set_visible_characters(13)
		await get_tree().create_timer(0.15).timeout
		i += 1

func show_login_text():
	$UsernameLabel.show()
	$PasswordLabel.show()

func _on_password_input_label_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		$PasswordLabel/PasswordInputLabel.clear()
		code_breaking_active = true
# The parameter number is converted to a string.
# Then it's appended to inputted_numbers and finally 
# inputted_numbers is shown in the Label.
# Called from the _process()
func add_to_inputted_numbers(number):
	inputted_numbers += var_to_str(number)
	$PasswordLabel/PasswordInputLabel.text = inputted_numbers

# Returns the inputted_numbers as an int.
# Used by level's to compare weapon's attack to
# the enemies' math problems
func get_result():
	print_debug(inputted_numbers)
	return inputted_numbers.to_int()

# Called when the player presses enter. 
# Inputted_numbers is resetted
# and the empty string is shown in
# Label. Replaces anything that was in
# Label beforehand.
func reset_inputs():
	inputted_numbers = ""
	$PasswordLabel/PasswordInputLabel.text = inputted_numbers

func try_against_correct_passcode():
	if get_result() == 1234:
		print_debug("Correct!")
		var sprite = Sprite2D.new()
		sprite.texture = load("res://art/sprites/correct_answer_placeholder.png")
		sprite.position.x = get_viewport().size.x / 2
		sprite.position.y = get_viewport().size.y / 2
		add_child(sprite)
	else:
		$PasswordLabel/Label.show()
		await get_tree().create_timer(1).timeout
		$PasswordLabel/Label.hide()
