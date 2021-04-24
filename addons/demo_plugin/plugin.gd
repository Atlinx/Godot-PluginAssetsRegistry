tool
extends EditorPlugin

const plugin_ui_scene = preload("plugin_ui.tscn")
var plugin_ui : PluginUI

var assets_registry = PluginAssetsRegistry.new(self)

func _enter_tree():
	plugin_ui = plugin_ui_scene.instance()
	add_control_to_bottom_panel(plugin_ui, "Demo Plugin")

# Call _setup_editor_assets in _ready since some child nodes may need to 
# fetch references to other nodes using get_node() in _ready()
# When _ready is called here, _ready has already been called on all the children 
func _ready():
	plugin_ui._setup_editor_assets(assets_registry)

func _exit_tree():
	remove_control_from_bottom_panel(plugin_ui)
	pass
