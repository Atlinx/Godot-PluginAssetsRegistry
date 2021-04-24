# PluginAssetsRegistry

A GDScript that scales assets used by plugins (like images and fonts) automatically based on the editor's current scale.

This script keeps a record of all loaded assets and does not duplicate the same asset more than once, which saves on memory.

## Installation

1. Copy the `plugin_assets_registry.gd` into your plugin's folder

```
res://
└─ addons
   └─ my_plugin
      └─ plugin_assets_registry.gd <- COPY HERE
```

2. Change `PLUGIN_ABSOLUTE_PATH_PREFIX` to be the path to your plugin's folder

```GDScript
# Inside "plugin_assets_registry.gd"

class_name PluginAssetsRegistry
extends Reference

# Replace 'demo_plugin' with your plugin's name
const PLUGIN_ABSOLUTE_PATH_PREFIX = "res://addons/demo_plugin/"

...
```

3. Create a new instance of `PluginAssetsRegistry` inside of your main plugin script that extends `EditorPlugin`, and pass in your plugin inside of the `new()` constructor

```GDScript
# Inside "plugin.gd"

extends EditorPlugin

var assets_registry = PluginAssetsRegistry.new(self)

...
```

## Use

`assets_registry.load_asset(asset_path: String)`

- Loads a scaled asset using a path that is relative to the plugin folder. (ie `assets/fonts/font.tres` has a real path of `res://addons/my_plugin/assets/fonts/font.tres`, where `res://addons/my_plugin` is the plugin folder.)

`assets_registry.load_asset(asset)`

- Loads a scaled asset using an already loaded asset

## Recommended Use

You should create a `_setup_editor_assets(asset_registry)` function in all the node you wish to use scaled assets and then have the plugin.gd script call `_setup_editor_assets` on those nodes, with the `assets_registry` as the argument. This lets each script load the assets they need since they have access to the `PluginAssetsRegistry` instance.

ie.
```GDScript
# Inside "plugin.gd"

extends EditorPlugin

var assets_registry = PluginAssetsRegistry.new(self)
var plugin_ui : PluginUI

...

func _ready():
   plugin_ui._setup_editor_assets(assets_registry)
  
...
```
 
```GDScript
# Inside "plugin_ui.gd"

class_name PluginUI
extends Control

var label: Label
var custom_button: CustomUISection

...

func _setup_editor_assets(assets_registry):
   label.add_font_override("font", assets_registry.load_asset("assets/fonts/my_font.tres"))

   # Chaining the _setup_editor_assets to child nodes
   CustomUISection._setup_editor_assets(assets_registry)

...
```
