extends Control



func _on_play_pressed():
	get_tree().change_scene_to_file("res://Levels/Level 1.tscn")
	
	pass # Replace with function body.


func _on_level_select_pressed():
	get_tree().change_scene_to_file("res://Levels/Level Select.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://Settings.tscn")


func _on_quit_pressed():
	get_tree().quit()






