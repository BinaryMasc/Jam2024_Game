extends Area2D



var button1: Button
var button2: Button
var button3: Button

var button_pressed_callback: Callable

var subs_node: Label
var subs_text: String
var subs_running:= false
var subs_waiting:= false
var subs_fast:= false
var subs_running_queue = []

var mouse_over:= false

var first_iteration := true

# Called when the node enters the scene tree for the first time.
func _ready():
	subs_node = get_node("/root/Node2D/Subs")
	button1 = get_node("/root/Node2D/Button1")
	button2 = get_node("/root/Node2D/Button2")
	button3 = get_node("/root/Node2D/Button3")
	_hide_buttons()
	
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	
	# Start jobs
	start_jobs()
	
	new_subtitle("Prueba de funcionamiento de los subtítulos.")
	new_subtitle("Prueba de funcionamiento. ¡Hola! ¡1, 2, 3!")
	new_subtitle("Bienvenido a esta historia.")
	new_subtitle_callback("Es hora de comer.", Callable(self, "gameflow_to_eat"))
	#_enable_and_show_buttons(1000)
	#new_subtitle("...")
	#new_subtitle("...")
	#new_subtitle("Bueno, ¿Quién tiene hambre?")
	#var callable = Callable(self, "new_subtitle").bind(msj)
	#Thread.new().start(callable)
	
func gameflow_to_eat():
	_enable_and_show_buttons(0, "Agua", "Carne", "Pan")
	button_pressed_callback = Callable(self, "gameflow_choose_to_eat")

func gameflow_choose_to_eat(option: int):
	if option == 1:
		new_subtitle("Bueno, no creo que eso sea suficiente." )
	elif option == 2:
		new_subtitle("Eso se ve delicioso.")
	else:
		new_subtitle("Muchos carbohidratos, ¿No crees?")

func _on_mouse_entered():
	#print("mouse enter")
	mouse_over = true
	
func _on_mouse_exited():
	#print("mouse exited")
	mouse_over = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	
	if first_iteration:
		#_hide_buttons()
		first_iteration = false
	pass

func _input(event):
	if event is InputEventMouseButton:
		
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT and mouse_over:
			print("click sobre el objeto")
			if not subs_running and subs_running_queue.size() == 0:
				new_subtitle("Joder, ¿Para qué tocas al SII? ¡Es peligroso!")
				new_subtitle("Mantente escondido. Podrías ir a la cárcel por evasión de impuestos.")
			return
		
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			print("click 2")

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if subs_waiting:
			subs_waiting = false
			subs_fast = false
		else:
			subs_fast = true
		
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			pass

func start_jobs():
	Thread.new().start(job_subtitles)

func job_subtitles():
	while true:
		if subs_running_queue.size() > 0 and not subs_running and not subs_waiting:
			subs_fast = false
			internal_sub_delegate(subs_running_queue[0].msg)
			
			if subs_running_queue[0].has_callback:
				subs_running_queue[0].callback.call()
			
			subs_running_queue.remove_at(0)
			print(subs_running_queue.size())
			subs_running = false
			subs_waiting = true
			#print(subs_running_queue)
			continue
		OS.delay_msec(100)

func new_subtitle(msg):
	subs_running_queue.append(Message.new(msg))

func new_subtitle_callback(msg: String, callback: Callable):
	subs_running_queue.append(Message.new(msg).set_callback(callback))

func internal_sub_delegate(msg):
	subs_running = true
	var callable = Callable(self, "new_subtitle_sync").bind(msg)
	var t = Thread.new()
	t.start(callable)
	t.wait_to_finish()
	

func _internal_update_subs(text):
	#subs_text = text
	if subs_node:
		subs_node.text = text

func new_subtitle_sync(msg):
	var it = 0
	for character in msg:
		var velo_multiplier = 3 if subs_fast else 1
		if character == ' ': # Añade una pausa adicional
			OS.delay_msec(35.0 / velo_multiplier)
		subs_text = ("" if it == 0 else subs_node.text) + character
		call_deferred("_internal_update_subs", subs_text)
		OS.delay_msec(50.0 / velo_multiplier)  
		it += 1



func _disable_and_hide_buttons(delay_ms: int):
	button1.disabled = true
	button2.disabled = true
	button3.disabled = true
	if delay_ms > 0:
		OS.delay_msec(delay_ms)
	_hide_buttons()
	
func _hide_buttons():
	button1.hide()
	button2.hide()
	button3.hide()
	
func _show_buttons():
	button1.show()
	button2.show()
	button3.show()
	
func _enable_and_show_buttons(delay_ms: int, msg1: String, msg2: String,msg3: String):
	button1.text = msg1
	button2.text = msg2
	button3.text = msg3
	#var callable = Callable(self, "new_subtitle").bind(msj)
	#Thread.new().start(callable)
	#var callable = Callable(self, "_internal_enable_and_show_buttons").bind(delay_ms)
	Thread.new().start(Callable(self, "_internal_enable_and_show_buttons").bind(delay_ms))
	

func _internal_enable_and_show_buttons(delay_ms: int):
	print("called")
	call_deferred("_show_buttons")
	if delay_ms > 0:
		OS.delay_msec(delay_ms)
	button1.disabled = false
	button2.disabled = false
	button3.disabled = false

func _on_buttons_pressed(id: int):
	button_pressed_callback.bind(id).call()
	_disable_and_hide_buttons(1000)
	subs_waiting = false
	

func _on_button1_pressed():
	print("botón 1 presionado")
	_on_buttons_pressed(1)
	

func _on_button2_pressed():
	print("botón 2 presionado")
	_on_buttons_pressed(2)


func _on_button3_pressed():
	print("botón 3 presionado")
	_on_buttons_pressed(3)
	
