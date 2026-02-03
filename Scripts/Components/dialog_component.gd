class_name DialogCommponent
extends Node

@export var initializer_name: String = "NPC"
@export var interact_type: String = "Interact"
@export var lines: Array[String]

@export var text :String
var options: Array[DialogOptions]
var is_last_line: bool
