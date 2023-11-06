extends Control
class_name  Multiplayer_Class

static var current:Multiplayer_Class

var Address = "127.0.0.1"
var port = 45142
var peer :ENetMultiplayerPeer
static var paired : bool= false
static var server : bool= false
@onready var local_game_button = $Local_Game_Button
@onready var host_button = $Host_Button
@onready var join_button = $Join_Button
@onready var chess_board = $Chess_Board
@onready var host_ip_text = $Host_Ip_Text
@onready var ip_text = $Ip_text
var config 

# Called when the node enters the scene tree for the first time.
func _ready():
#	config = GotmConfig.new()
#	config.project_key = "authenticators/7CRGSF4u6Q5WMC5aOqLZ"
#	Gotm.initialize(config)

	ip_text.text = "Local IP: \n" + IP.resolve_hostname(str(OS.get_environment("COMPUTERNAME")),1)
	
	current = self
	multiplayer.peer_connected.connect(_peer_connected)
	multiplayer.peer_disconnected.connect(_peer_disconnected)
	multiplayer.connected_to_server.connect(_connected_to_server)
	multiplayer.server_disconnected.connect(_disconnected_from_server)
	multiplayer.connection_failed.connect(_conection_failed)
	local_game_button.pressed.connect(_start_game)
	host_button.pressed.connect(_host_game)
	join_button.pressed.connect(_join_game)
	
	peer = ENetMultiplayerPeer.new()


func _start_game():
	if !paired:
		_start_local()
	elif server:
		_call_game_start.rpc()

func _host_game():
	var error = peer.create_server(port,2)
	if error != OK:
		if error == 20:
			print("Game Already Hosted")
			return
			
		print("Cannot host: " + str(error))
		return
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	server = true
	host_ip_text.editable = false
	join_button.disabled = true
	print("Hosting Server")

func _join_game():
	peer.close()
	if host_ip_text.text != "":
		Address = host_ip_text.text
	else:
		Address = "127.0.0.1"
	print("Connecting to :"+str(Address))
	var error = peer.create_client(Address,port)
	if error != OK:
		print("Cannot join: " + str(error))
		return
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	paired = true
	multiplayer.set_multiplayer_peer(peer)
	local_game_button.text = "Connecting"

func _conection_failed(id):
	paired = false
	local_game_button.text = "Local Game"
	print("Conection Failed")

func _peer_connected(id):
	paired = true
	local_game_button.text = "Online Game"
	print("Player Connected:" + str(id))
	
func _disconnected_from_server(id):
	local_game_button.text = "Local Game"
	paired = false
	print("Disconected from server")

func _peer_disconnected(id):
	local_game_button.text = "Local Game"
	paired = false
	print("Player Disconected:" + str(id))
	
func _connected_to_server():
	local_game_button.text = "Online Game"
	paired = true
	print("Conected to server")

func _start_local():
	chess_board.visible = true
	local_game_button.disabled = true
	local_game_button.visible = false
	host_button.disabled = true
	host_button.visible = false
	join_button.disabled = true
	join_button.visible = false
	host_ip_text.editable = false
	host_ip_text.visible = false
	ip_text.visible = false

@rpc("call_remote","any_peer","reliable")
func start_sending_move():
	Board.current.receive_new_move()
	
@rpc("call_remote","any_peer","reliable")
func send_tile(row,col,piece,colour,unmoved,enpassantable):
	Board.current.receive_tile(row,col,piece,colour,unmoved,enpassantable)

@rpc("call_remote","any_peer","reliable")
func sent_move(white_turn):
	Board.current.move_received(white_turn)

@rpc("call_local","authority","reliable")
func _call_game_start():
	Board.current.online = true
	chess_board.visible = true
	local_game_button.disabled = true
	local_game_button.visible = false
	host_button.disabled = true
	host_button.visible = false
	join_button.disabled = true
	join_button.visible = false
	host_ip_text.editable = false
	host_ip_text.visible = false
	ip_text.visible = false
