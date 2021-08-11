tool
class_name PluginUI
extends Control


export(Array, NodePath) var custom_label_paths: Array
export(Array, NodePath) var button_paths: Array

var custom_labels: Array
var buttons: Array


func _ready():
	custom_labels = []
	for path in custom_label_paths:
		custom_labels.append(get_node(path))
	
	buttons = []
	for path in button_paths:
		buttons.append(get_node(path))


func _setup_editor_assets(assets_registry):
	for label in custom_labels:
		label.add_font_override("font", assets_registry.load_asset(label.get_font("font")))
	
	for button in buttons:
		button.icon = assets_registry.load_asset("assets/play.svg")
		
	print("Assets registry contains:")
	for key in assets_registry.loaded_editor_assets.keys():
		print(str(key))
	print()
