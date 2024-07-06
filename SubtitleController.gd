extends Node

# Script para controlar subtítulos y botones de decisiones.
# Este script debe ser llamado por SubtitleController una vez por escena
class_name SubtitleController

var button1: Button
var button2: Button
var button3: Button

var button_pressed_callback: Callable

var subs_node: Label
var countdown_node: Label
var remitent_node: Label
var subs_text: String
var subs_running:= false
var subs_waiting:= false
var subs_fast:= false
var buttons_enabled := false
var subs_running_queue = []

var mouse_over:= false
var debug_mode:= false


func _ready():
	subs_node = $Subs
	remitent_node = $Remitent
	button1 = $Button1
	button2 = $Button2
	button3 = $Button3
	countdown_node = $CountDown
	_hide_buttons()
	
	# Start jobs
	start_jobs()



@warning_ignore("unused_parameter")
func _process(delta):
	pass

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
	Thread.new().start(_job_subtitles)

func _job_subtitles():
	while true:
		if subs_running_queue.size() > 0 and not subs_running and not subs_waiting:
			subs_fast = false
			call_deferred("_internal_sub_set_sender", subs_running_queue[0].who)
			_internal_sub_delegate(subs_running_queue[0].msg)
			
			if subs_running_queue[0].has_callback:
				subs_running_queue[0].callback.call()
			
			subs_running_queue.remove_at(0)
			subs_running = false
			subs_waiting = true
			continue
		OS.delay_msec(100)

func new_subtitle(who: String, msg: String):
	subs_running_queue.append(Message.new(who, msg))

func get_subs_size():
	return subs_running_queue.size()

func is_subs_running():
	return subs_running

func new_subtitle_callback(who: String, msg: String, callback: Callable):
	subs_running_queue.append(Message.new(who, msg).set_callback(callback))

func new_question(label_button1: String, label_button2: String, label_button3: String, callback: Callable, response_time:= -1):
	if response_time > 0:
		Thread.new().start(Callable(self, "_question_loop_handler").bind(response_time))
	
	button_pressed_callback = callback
	_enable_and_show_buttons(0, label_button1, label_button2, label_button3)

func _question_loop_handler(response_time: int):
	var time = response_time
	buttons_enabled = true
	
	while time > 0 and buttons_enabled:
		call_deferred("_countdown_node_updater", str(time))
		OS.delay_msec(1000)
		time -= 1
	if time == 0:
		_on_buttons_pressed(-1)

func _countdown_node_updater(time: String):
	countdown_node.text = time

func _internal_sub_delegate(msg):
	subs_running = true
	var callable = Callable(self, "_new_subtitle_sync").bind(msg)
	var t = Thread.new()
	t.start(callable)
	t.wait_to_finish()


func _internal_sub_set_sender(who: String):
	remitent_node.text = who

func _internal_update_subs(text):
	#subs_text = text
	if subs_node:
		subs_node.text = text

func _new_subtitle_sync(msg):
	var it = 0
	
	if debug_mode:
		call_deferred("_internal_update_subs", msg)
		return
	
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
	
func _enable_and_show_buttons(delay_ms: int, msg1: String, msg2: String, msg3: String):
	buttons_enabled = true
	button1.text = msg1
	button2.text = msg2
	button3.text = msg3
	Thread.new().start(Callable(self, "_internal_enable_and_show_buttons").bind(delay_ms))
	

func _internal_enable_and_show_buttons(delay_ms: int):
	call_deferred("_show_buttons")
	if delay_ms > 0:
		OS.delay_msec(delay_ms)
	button1.disabled = false
	button2.disabled = false
	button3.disabled = false

func _on_buttons_pressed(id: int):
	buttons_enabled = false
	call_deferred("_countdown_node_updater", str(""))
	call_deferred("_disable_and_hide_buttons", 0)
	button_pressed_callback.bind(id).call()
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
	
