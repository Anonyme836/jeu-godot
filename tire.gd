extends Node

signal je_tir

func _on_timer_timeout() -> void:
	je_tir.emit()
