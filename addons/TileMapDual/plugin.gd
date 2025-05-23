@tool
class_name TileMapDualEditorPlugin
extends EditorPlugin

static var instance: TileMapDualEditorPlugin = null


# TODO: create a message queue that groups warnings, errors, and messages into categories
# so that we don't get 300 lines of the same warnings pushed to console every time we undo/redo


func _enter_tree() -> void:
	instance = self
	add_custom_type("TileMapDual", "TileMapLayer", preload("TileMapDual.gd"), preload("TileMapDual.svg"))
	add_custom_type("CursorDual", "Sprite2D", preload("CursorDual.gd"), preload("CursorDual.svg"))
	add_custom_type("TileMapDualLegacy", "TileMapLayer", preload("TileMapDualLegacy.gd"), preload("TileMapDual.svg"))
	print("plugin TileMapDual loaded")


func _exit_tree() -> void:
	instance = null
	remove_custom_type("CursorDual")
	remove_custom_type("TileMapDual")
	remove_custom_type("TileMapDualLegacy")
	print("plugin TileMapDual unloaded")


static func popup(title: String, message: String) -> void:
	var popup := AcceptDialog.new()
	instance.get_editor_interface().get_base_control().add_child(popup)
	popup.name = 'TileMapDualPopup'
	popup.title = title
	popup.dialog_text = message
	popup.popup_centered()
	await popup.confirmed
	popup.queue_free()
