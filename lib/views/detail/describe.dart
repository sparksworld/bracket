import '/model/film_play_info/data.dart';
import '/model/film_play_info/detail.dart';
import '/plugins.dart';

class Describe extends StatefulWidget {
  final Data? data;
  const Describe({super.key, this.data});

  @override
  State<Describe> createState() => _DescribeState();
}

class _DescribeState extends State<Describe> {
  Detail? get _detail {
    return widget.data?.detail;
  }

  @override
  Widget build(BuildContext context) {
    return LoadingViewBuilder(
      loading: widget.data == null,
      builder: (_) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                (_detail?.descriptor?.blurb ?? '').trim(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
