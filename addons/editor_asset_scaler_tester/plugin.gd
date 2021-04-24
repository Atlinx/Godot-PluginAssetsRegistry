tool
extends EditorPlugin

const ui_scene = preload("ui.tscn")
var ui: Control

func _enter_tree():
	print("Current DPI is " + str(OS.get_screen_dpi()))
	ui = ui_scene.instance()
	add_control_to_bottom_panel(ui, "Asset Scale Test")
	pass


func _exit_tree():
	remove_control_from_bottom_panel(ui)
	pass
