# Created by Freeknight
# Date: 2021/12/13
# Desc：保存编辑器环境的配置文件
# @category: 辅助类
#--------------------------------------------------------------------------------------------------
tool
extends Node
### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------
#--- enums ----------------------------------------------------------------------------------------
#--- constants ------------------------------------------------------------------------------------
#--- public variables - order: export > normal var > onready --------------------------------------
const lastopenedfile_path : String = "res://addons/FKEditor_FileEditor/EditorConfig.ini"
#--- private variables - order: export > normal var > onready -------------------------------------
### -----------------------------------------------------------------------------------------------

### Built in Engine Methods -----------------------------------------------------------------------
func _ready():
	pass
### -----------------------------------------------------------------------------------------------

### Public Methods --------------------------------------------------------------------------------
func store_opened_files(filecontainer : Control):
	var file = ConfigFile.new()
	file.load(lastopenedfile_path)
	for child in range(0,filecontainer.get_item_count()):
		var filepath = filecontainer.get_item_metadata(child)[0].current_path
		file.set_value("Opened",filepath.get_file(),filepath)
	
	file.save(lastopenedfile_path)
# ------------------------------------------------------------------------------
func remove_opened_file(index : int , filecontainer : Control):
	var file = ConfigFile.new()
	file.load(lastopenedfile_path)
	var filepath = filecontainer.get_item_metadata(index)[0].current_path
	file.set_value("Opened",filepath.get_file(),null)
	file.save(lastopenedfile_path)
# ------------------------------------------------------------------------------
func load_opened_files() -> Array:
	var file = ConfigFile.new()
	file.load(lastopenedfile_path)
	var keys = []
	# Load opened files
	if file.has_section("Opened"):
		var openedfiles = file.get_section_keys("Opened")
		for openedfile in openedfiles:
			keys.append([openedfile, file.get_value("Opened",openedfile), \
				file.get_value("Fonts",openedfile) if file.has_section_key("Fonts",openedfile) else "null"])
	return keys
# ------------------------------------------------------------------------------
func store_editor_fonts(file_name : String, font_path : String):
	var file = ConfigFile.new()
	file.load(lastopenedfile_path)
	file.set_value("Fonts",file_name,font_path)
	file.save(lastopenedfile_path)
# ------------------------------------------------------------------------------
func get_editor_font():
	var editor_plugin : EditorPlugin = EditorPlugin.new()
	return editor_plugin.get_editor_interface().get_editor_settings().get_setting("interface/editor/code_font")
### -----------------------------------------------------------------------------------------------

### Private Methods -------------------------------------------------------------------------------
### -----------------------------------------------------------------------------------------------
