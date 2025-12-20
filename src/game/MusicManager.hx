package game;

import raylib.Raylib.*;
import raylib.Types;

// The game's music system.
class MusicManager {

	public static var music = [
		"The Dread",
		"HeavyContainment",
		"EntranceZone",
		"PD",
		"079",
		"GateB1",
		"GateB2",
		"Room3Storage",
		"Room049",
		"8601",
		"106",
		"Menu",
		"8601Cancer",
		"Intro",
		"178",
		"PDTrench",
		"205",
		"GateA",
		"1499",
		"1499Danger",
		"049Chase",
		"../Ending/MenuBreath",
		"914",
		"Ending",
		"Credits",
		"SaveMeFrom"
	];

	public static var isPlaying : Bool = true;
	public static var nowPlaying = 11;
	public static var playingNext = 11;
	static var currentVolume : Float = 1.0;
	public static var musicStream : Music;

	public static function init() {
		//musicStream = LoadMusicStream("assets/SFX/Music/"+music[nowPlaying]+".ogg");
		musicStream = LoadMusicStream("assets/SFX/Music/Menu.ogg");
		PlayMusicStream(musicStream);
	}

	public static function update() {
		UpdateMusicStream(musicStream);
		//trace(IsMusicStreamPlaying(musicStream));
		if (playingNext != nowPlaying) {
			currentVolume = Math.max(currentVolume - (Game.FPSfactor / 250.0), 0);
			if (currentVolume == 0) {
				StopMusicStream(musicStream);
				UnloadMusicStream(musicStream);
				nowPlaying = playingNext;
				isPlaying = false;
			}
		} else {
			// TODO: Add functional options, allowing you to tweak the music volume.
			currentVolume = currentVolume + (1.0 - currentVolume) * (0.1*Game.FPSfactor);
		}

		if (!isPlaying) {
			musicStream = LoadMusicStream("assets/SFX/Music/"+music[nowPlaying]+".ogg");
			PlayMusicStream(musicStream);
			isPlaying = true;
		}

		SetMusicVolume(musicStream,currentVolume);
	}
}
