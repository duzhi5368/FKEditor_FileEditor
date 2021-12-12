# Created by Freeknight
# Date: 2021/12/13
# Desc：入口函数
# @category: 主入口
#--------------------------------------------------------------------------------------------------
tool
extends EditorPlugin
### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------
#--- enums ----------------------------------------------------------------------------------------
#--- constants ------------------------------------------------------------------------------------
#--- public variables - order: export > normal var > onready --------------------------------------
var IconLoader = preload("res://addons/FKEditor_FileEditor/Scripts/IconLoader.gd").new()
var FileEditor
#--- private variables - order: export > normal var > onready -------------------------------------
### -----------------------------------------------------------------------------------------------

### Built in Engine Methods -----------------------------------------------------------------------
func _enter_tree():
	add_autoload_singleton("EditorConfig","res://addons/FKEditor_FileEditor/Scripts/EditorConfig.gd")
	FileEditor = preload("./Scenes/FileEditor.tscn").instance()
	get_editor_interface().get_editor_viewport().add_child(FileEditor)
	FileEditor.hide()
# ------------------------------------------------------------------------------
func _exit_tree():
	remove_autoload_singleton("EditorConfig")
	get_editor_interface().get_editor_viewport().remove_child(FileEditor)
# ------------------------------------------------------------------------------
func has_main_screen():
	return true
# ------------------------------------------------------------------------------
func get_plugin_name():
	return "FKEditor_FileEditor"
# ------------------------------------------------------------------------------
func get_plugin_icon():
	return IconLoader.load_icon_from_name("file")
# ------------------------------------------------------------------------------
func make_visible(visible):
	FileEditor.visible = visible
### -----------------------------------------------------------------------------------------------

### Public Methods --------------------------------------------------------------------------------
### -----------------------------------------------------------------------------------------------

### Private Methods -------------------------------------------------------------------------------
### -----------------------------------------------------------------------------------------------


