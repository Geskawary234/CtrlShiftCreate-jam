extends AudioStreamPlayer


@export_dir var music

var randomizer : AudioStreamRandomizer = AudioStreamRandomizer.new()
func _ready() -> void:

	for track in DirAccess.get_files_at(music):
		if '.import' not in track:
			var path : String = music+'/'+track
			
			var st = load(path)
			
			randomizer.add_stream(0,st)
	
	stream = randomizer
	
	finished.connect(play)
	play()
	
