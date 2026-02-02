class_name DialogCommponent
extends Node

@export var dialog_type: DIALOG_TYPE
@export var initializer_name: String = "NPC"
@export var interact_type: String = "Interact"
@export var lines : Array[String] = ["No Dialog set","Test"]

enum DIALOG_TYPE {QUEST, CHAT}
