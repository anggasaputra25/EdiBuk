import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class BookPlay extends StatefulWidget {
  final String imageUrl;
  final String audio;
  final String title;
  final String author;
  final String body;

  const BookPlay({
    Key? key,
    required this.imageUrl,
    required this.audio,
    required this.title,
    required this.author,
    required this.body,
  }) : super(key: key);

  @override
  State<BookPlay> createState() => _BookPlayState();
}

class _BookPlayState extends State<BookPlay> {
  bool isFavorite = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    _audioPlayer.onDurationChanged.listen((d) {
      setState(() => _duration = d);
    });

    _audioPlayer.onPositionChanged.listen((p) {
      setState(() => _position = p);
    });
  }

  void _playPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(UrlSource(widget.audio));
    }
    setState(() => _isPlaying = !_isPlaying);
  }

  void _seekTo(double seconds) {
    _audioPlayer.seek(Duration(seconds: seconds.toInt()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            // Top Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBorderedIcon(Icons.arrow_back, () {
                  Navigator.pop(context);
                }),
                const Text(
                  "Sedang Diputar",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
                _buildBorderedIcon(Icons.more_vert, () {
                  print("Menu clicked!");
                }),
              ],
            ),
            const SizedBox(height: 26),

            // Cover Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.imageUrl,
                height: 344,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 25),

            // Info, Slider, Buttons
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTitleAndFavorite(),
                    _buildSlider(),
                    _buildTimeInfo(),
                    const SizedBox(height: 25),
                    _buildControls(),
                    const SizedBox(height: 25),
                    const Text(
                      'Isi Buku',
                      style: TextStyle(color: Colors.grey),
                    ),
                    IconButton(
                      icon: const Icon(Icons.keyboard_arrow_down, size: 30),
                      color: Colors.grey,
                      onPressed: () {},
                    ),
                    Text(
                      widget.body,
                      style: const TextStyle(color: Colors.grey),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBorderedIcon(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x2608060E), width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: IconButton(
        icon: Icon(icon, size: 20, color: Colors.black),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildTitleAndFavorite() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            Text(
              widget.author,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_outline,
            size: 24,
            color: Colors.redAccent,
          ),
          onPressed: () => setState(() => isFavorite = !isFavorite),
        ),
      ],
    );
  }

  Widget _buildSlider() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: const Color(0xFF6467F6),
        inactiveTrackColor: const Color(0xFF6467F6).withOpacity(0.3),
        thumbColor: const Color(0xFF6467F6),
        overlayColor: const Color(0xFF6467F6).withOpacity(0.2),
        trackHeight: 2.5,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
      ),
      child: Slider(
        value: _position.inSeconds.toDouble(),
        min: 0,
        max: _duration.inSeconds.toDouble(),
        onChanged: _seekTo,
      ),
    );
  }

  Widget _buildTimeInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildTimeText(_position), _buildTimeText(_duration)],
    );
  }

  Widget _buildTimeText(Duration time) {
    final minutes = time.inMinutes;
    final seconds = time.inSeconds.remainder(60).toString().padLeft(2, '0');
    return Text(
      '$minutes:$seconds',
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous, size: 35),
          color: Colors.grey,
          onPressed: () {},
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF6467F6),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, size: 35),
              color: Colors.white,
              onPressed: _playPause,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.skip_next, size: 35),
          color: Colors.grey,
          onPressed: () {},
        ),
      ],
    );
  }
}
