extends Control
@onready var tampilan = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = FileAccess.open("user://user_data.dat", FileAccess.READ)
	var content = file.get_var()
	tampilan.text = "Register Berhasil!\n"
	tampilan.text += "Username: " + content["username"] + "\n"
	tampilan.text += "Email: " + content["email"] + "\n"
	tampilan.text += "Nomor Telepon: " + content["telp"] + "\n"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
