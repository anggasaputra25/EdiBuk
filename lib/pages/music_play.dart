import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlay extends StatefulWidget {
  const MusicPlay({super.key});

  @override
  State<MusicPlay> createState() => _MusicPlayState();
}

class _MusicPlayState extends State<MusicPlay> {
  bool isFavorite = false;
  AudioPlayer _audioPlayer = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    _audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });

    _audioPlayer.onPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });
  }

  void _playPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(
          UrlSource("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _seekTo(double seconds) {
    _audioPlayer.seek(Duration(seconds: seconds.toInt()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0x2608060E), width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, size: 20, color: Colors.black),
                      onPressed: () {
                        print("Back click!");
                      },
                    ),
                  ),
                  Text("Sedang Diputar", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0x2608060E), width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.more_vert, size: 20, color: Colors.black),
                      onPressed: () {
                        print("Menu clicked!");
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 26),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  height: 344,
                  'https://i.pinimg.com/736x/3e/43/81/3e4381b778491865ef08b89d48c9366a.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 25),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Kita ke Sana", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
                              Text("Hindia",  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.grey),),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_outline, 
                              size: 24, 
                              color: Colors.redAccent,
                              // color: isFavorite ? Colors.redAccent : Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Color(0xFF6467F6), // Warna track yang sudah terisi
                                inactiveTrackColor: Color(0xFF6467F6).withOpacity(0.3), // Warna track yang belum terisi
                                thumbColor: Color(0xFF6467F6), // Warna lingkaran (thumb)
                                overlayColor: Color(0xFF6467F6).withOpacity(0.2), // Efek saat thumb ditekan
                                trackHeight: 2.5, // Tinggi track lebih kecil
                                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6), // Ukuran thumb lebih kecil
                                overlayShape: RoundSliderOverlayShape(overlayRadius: 10),
                              ),
                              child: Slider(
                                value: _position.inSeconds.toDouble(),
                                min: 0,
                                max: _duration.inSeconds.toDouble(),
                                onChanged: (value) {
                                  _seekTo(value);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${_position.inMinutes}:${_position.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
                          ),
                          Text(
                            "${_duration.inMinutes}:${_duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            color: Colors.grey,
                            icon: Icon(Icons.skip_previous, size: 35),
                            onPressed: () {
                              print('Previous Clicked!');
                            },
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Color(0xFF6467F6),
                            ),
                            child: Center(
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, size: 35), // Reduce size if needed
                                onPressed: _playPause,
                              ),
                            ),
                          ),
                          IconButton(
                            color: Colors.grey,
                            icon: Icon(Icons.skip_next, size: 35),
                            onPressed: () {
                              print('Previous Clicked!');
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 25),
                      Text('Isi Buku', style: TextStyle(color: Colors.grey)),
                      IconButton(
                        color: Colors.grey,
                        icon: Icon(Icons.keyboard_arrow_down, size: 30),
                        onPressed: () {
                          print('Content Book Clicked!');
                        },
                      ),
                      Text('Mengisahkan petualangan Monkey D Luffy, seorang anak laki-laki yang memiliki kemampuan tubuh elastis seperti karet setelah memakan Buah Iblis secara tidak disengaja. Luffy bersama kru bajak lautnya, yang dinamakan Bajak Laut Topi Jerami.', style: TextStyle(color: Colors.grey),)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}