/*
class TimedAudio extends Holder {
  final String file;
  final List<List<TextHolder>> timedSpans;
  final List<double> times;
  const TimedAudio(
      {required this.timedSpans, required this.times, required this.file});

  @override
  Widget element(BuildContext context) {
    return TimedAudioW(timedSpans: timedSpans, times: times, audio: file);
  }

  @override
  Widget fallback(BuildContext context) {
    return const Placeholder();
  }
}

class TimedAudioW extends StatefulWidget {
  final String audio;
  final List<List<TextHolder>> timedSpans;
  final List<double> times;
  const TimedAudioW(
      {super.key,
      required this.timedSpans,
      required this.times,
      required this.audio});

  @override
  State<TimedAudioW> createState() => _TimedAudioState();
}

class _TimedAudioState extends State<TimedAudioW> {
  int startTime = 0;
  int curTimeIx = -1;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    // .setAudioSource(AudioSource.asset('cargoship/audio/${widget.audio}'))

    _audioPlayer
        .setAudioSource(AudioSource.asset('cargoship/audio/Hey Ya.wav'))
        .catchError((error) {
      // catch load errors: 404, invalid url ...
      log("An error occurred $error");
      return const Duration(seconds: 3);
    });
    log('Audio source ${_audioPlayer.audioSource.toString()}  ${widget.audio}');
    curTimeIx = -1;
    log('Audio play ${_audioPlayer.duration}');
    //Future.delayed(const Duration(milliseconds: 500), start);
  }

  get length => widget.times.length;
  int time(ix) {
    if (ix < 0) return 0;
    return (widget.times[ix] * 1000).toInt();
  }

  void start() {
    log('Audio start');
    startTime = DateTime.timestamp().millisecondsSinceEpoch;
    Future.delayed(Duration(milliseconds: math.min(1, time(0))), update);
    _audioPlayer.play();
    log('Audio start2 ${_audioPlayer.duration}');
  }

  void update() {
    int advIx = curTimeIx + 1;
    int advAmt = 1;
    bool searchComplete = false;
    while (!searchComplete) {
      searchComplete = true;
      if (advIx < widget.times.length) {
        int ms = time(advIx) - time(advIx - 1);
        if (ms > 0) {
          Future.delayed(Duration(milliseconds: ms), update);
        } else {
          advAmt += 1;
          searchComplete = false;
        }
      }
    }
    log('Ix:= ${curTimeIx + advAmt}');
    setState(() {
      curTimeIx += advAmt;
    });
  }

  // Helper function
  Widget renderSpans(int n, BuildContext context,
      {CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start}) {
    var spans = widget.timedSpans[n];
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        children: [for (TextHolder s in spans) s.element(context)]);
  }

  // Helper function
  Widget renderSuper(BuildContext context,
      {CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start}) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          for (int n = 0; n <= curTimeIx; n++) renderSpans(n, context)
        ]);
  }

  @override
  Widget build(BuildContext context) {
    if (!_audioPlayer.playing) {
      start();
    }
    return Padding(
        padding: const EdgeInsets.only(bottom: 300),
        child: renderSuper(context));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
*/
