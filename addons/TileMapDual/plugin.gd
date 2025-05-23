@tool
class_name TileMapDualEditorPlugin
extends EditorPlugin

static var instance: TileMapDualEditorPlugin = null
var _popup: AcceptDialog


# TODO: create a message queue that groups warnings, errors, and messages into categories
# so that we don't get 300 lines of the same warnings pushed to console every time we undo/redo


func _enter_tree() -> void:
	_init_instance()
	add_custom_type("TileMapDual", "TileMapLayer", preload("TileMapDual.gd"), preload("TileMapDual.svg"))
	add_custom_type("CursorDual", "Sprite2D", preload("CursorDual.gd"), preload("CursorDual.svg"))
	add_custom_type("TileMapDualLegacy", "TileMapLayer", preload("TileMapDualLegacy.gd"), preload("TileMapDual.svg"))
	print("plugin TileMapDual loaded")


func _exit_tree() -> void:
	remove_custom_type("CursorDual")
	remove_custom_type("TileMapDual")
	remove_custom_type("TileMapDualLegacy")
	_deinit_instance()
	print("plugin TileMapDual unloaded")


func _init_instance() -> void:
	_popup = AcceptDialog.new()
	_popup.name = 'ErrorPopup'
	get_editor_interface().get_base_control().add_child(_popup)
	instance = self


func _deinit_instance() -> void:
	_popup.queue_free()


static func popup(title: String, message: String) -> void:
	instance._popup.title = title
	instance._popup.dialog_text = message
	instance._popup.popup_centered()
