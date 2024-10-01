extends Control

@onready var username_input = $PanelContainer/MarginContainer/VBoxContainer/Username/MarginContainer/VBoxContainer/HBoxContainer/LineEdit
@onready var email_input = $PanelContainer/MarginContainer/VBoxContainer/Email/MarginContainer/VBoxContainer/HBoxContainer/LineEdit
@onready var telp_input = $PanelContainer/MarginContainer/VBoxContainer/Telp/MarginContainer/VBoxContainer/HBoxContainer/LineEdit
@onready var password_input = $PanelContainer/MarginContainer/VBoxContainer/Password/MarginContainer/VBoxContainer/HBoxContainer/LineEdit
@onready var register_button = $PanelContainer/MarginContainer/VBoxContainer/Button
@onready var error_username = $PanelContainer/MarginContainer/VBoxContainer/Username/MarginContainer/VBoxContainer/Error
@onready var error_email = $PanelContainer/MarginContainer/VBoxContainer/Email/MarginContainer/VBoxContainer/Error
@onready var error_telp = $PanelContainer/MarginContainer/VBoxContainer/Telp/MarginContainer/VBoxContainer/Error
@onready var error_password = $PanelContainer/MarginContainer/VBoxContainer/Password/MarginContainer/VBoxContainer/Error

func validate_username(username: String) -> bool:
	var username_pattern = r"^[a-zA-Z0-9._]{3,20}$"
	var regex = RegEx.new()
	regex.compile(username_pattern)
	return regex.search(username) != null

func validate_email(email: String) -> bool:
	var email_pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
	var regex = RegEx.new()
	regex.compile(email_pattern)
	return regex.search(email) != null

func validate_phone_number(phone_number: String) -> bool:
	var phone_pattern = r"^(0|\+[0-9]{2,3}[\s-]?)?[0-9]{3,4}[\s-]?[0-9]{3,4}[\s-]?[0-9]{3,5}$"
	var regex = RegEx.new()
	regex.compile(phone_pattern)
	return regex.search(phone_number) != null

func validate_password(password: String) -> bool:
	var password_pattern = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
	var regex = RegEx.new()
	regex.compile(password_pattern)
	return regex.search(password) != null

func extract_numbers(text: String) -> String:
	var number_pattern = r"\d+"
	var regex = RegEx.new()
	regex.compile(number_pattern)
	var result = ""
	var search = regex.search(text)
	while search:
		result += search.get_string()
		search = regex.search(text, search.get_end())
	return result
	
func on_register_button_pressed():
	var username = username_input.text
	var email = email_input.text
	var telp = telp_input.text
	var password = password_input.text
	var ok = true

	if username == "" or not validate_username(username):
		error_username.text = "Username tidak valid. Harus berisi minimal 3 karakter dengan huruf, angka, titik, atau garis bawah."
		ok = false
	else:
		error_username.text = ""
	
	if email == "" or not validate_email(email):
		error_email.text = "Email tidak valid."
		ok = false
	else:
		error_email.text = ""
	
	if telp == "" or not validate_phone_number(telp):
		error_telp.text = "Nomor telepon tidak valid. Harus berupa angka 7-15 digit dan bisa dimulai dengan +."
		ok = false
	else:
		error_telp.text = ""

	if password == "" or not validate_password(password):
		error_password.text = "Password tidak valid. Harus berisi minimal 8 karakter, termasuk huruf besar, kecil, angka, dan simbol."
		ok = false
	else:
		error_password.text = ""
	
	if ok:
		var file = FileAccess.open("user://user_data.dat", FileAccess.WRITE)
		file.store_var({"username": username, "email": email, "telp": extract_numbers(telp), "password": password})
		file.close()
		get_tree().change_scene_to_file("res://berhasil.tscn")

func _ready():
	var password = ["aaAA11!!", "aaAA11__", "Aa1!", "aaaaaaaa", "aAaAaAaA", "aAaAA1!!"]
	for elm in password:
		if validate_password(elm):
			print(elm + " Valid")
		else:
			print(elm + " Tidak Valid")
	register_button.connect("pressed", Callable(self, "on_register_button_pressed"))
