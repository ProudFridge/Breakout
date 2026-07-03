extends Node
# This node is inteded to be used as an autoload
# TODO: Add a limit to the amount of times the same sound can be played
# TODO: Add automatic loading? Better way to add more sound?
# refer to: https://www.youtube.com/watch?v=Egf2jgET3nQ&t=306s

# Stores the audio ressources
static var audio_streams: Dictionary[String, Array] = {
	"bounce": [preload("res://assets/sound_effects/bounce1.wav"),
				preload("res://assets/sound_effects/bounce2.wav"),
				preload("res://assets/sound_effects/bounce3.wav"),
				preload("res://assets/sound_effects/bounce4.wav"),
				preload("res://assets/sound_effects/bounce5.wav")]
}

# Plays a selected sound from the audio_streams dictionnary
func play_sound(sound_name: String) -> void:
	var sound: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	var array: Array = audio_streams[sound_name]
	
	add_child(sound)
	
	sound.stream = array[randi_range(0, array.size() - 1)]
	sound.volume_db = -10
	sound.play()
	
	sound.finished.connect(func () -> void:
		sound.queue_free()
	)
