import '/plugins.dart';

class VideoBuilder extends StatefulWidget {
  const VideoBuilder({
    super.key,
    required this.controllerProvider,
  });

  final Widget controllerProvider;

  @override
  State<VideoBuilder> createState() => _VideoBuilderState();
}

class _VideoBuilderState extends State<VideoBuilder> {
  @override
  void initState() {
    print('initState');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    super.initState();
  }

  @override
  dispose() {
    print('dispose');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Theme(
              data: Theme.of(context).copyWith(
                platform: TargetPlatform.android,
              ),
              child: OverflowBox(
                child: widget.controllerProvider,
              ),
            ),
          ),
        ],
      ),
    );
  }
}