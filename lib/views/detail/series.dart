import 'package:bracket/model/film_detail/data.dart';
import 'package:bracket/model/film_detail/detail.dart';
import 'package:bracket/model/film_detail/play_list.dart';
import 'package:bracket/plugins.dart';

class Series extends StatefulWidget {
  final Function(int, int) callback;
  final int initOriginIndex;
  final int initTeleplayIndex;
  final Data? data;
  const Series({
    Key? key,
    this.data,
    required this.callback,
    required this.initOriginIndex,
    required this.initTeleplayIndex,
  }) : super(key: key);

  @override
  State<Series> createState() =>
      _SeriesState(initOriginIndex, initTeleplayIndex);
}

class _SeriesState extends State<Series> {
  int _originIndex;
  int _teleplayIndex;

  _SeriesState(this._originIndex, this._teleplayIndex);

  List<List<PlayList>?>? get _playList {
    return widget.data?.detail?.playList ?? [];
  }

  Detail? get _detail {
    return widget.data?.detail;
  }

  List<PlayList?> _playListItem(i) {
    return _playList?[i] ?? [];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      loading: widget.data == null,
      builder: (_) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  _detail?.name ?? '',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  _detail?.descriptor?.subTitle ?? '',
                  style: TextStyle(
                    color: Theme.of(context).disabledColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Divider(),
              const SizedBox(
                height: 12,
              ),
              SegmentedButton(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onSelectionChanged: (value) {
                  setState(() {
                    _originIndex = value.first;
                    widget.callback(_originIndex, _teleplayIndex);
                  });
                },
                segments: (_playList ?? [])
                    .mapIndexed(
                      (index, element) => ButtonSegment(
                        value: index,
                        label: Text('源${index + 1}'),
                      ),
                    )
                    .toList(),
                selected: {
                  _originIndex,
                },
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _playListItem(_originIndex).isNotEmpty
                            ? Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: _playListItem(_originIndex)
                                    .mapIndexed(
                                      (i, e) => OutlinedButton(
                                        style: ButtonStyle(
                                          side: MaterialStateProperty.all(
                                            BorderSide(
                                              color: i == _teleplayIndex
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                  : Theme.of(context)
                                                      .disabledColor,
                                              width: 2,
                                            ),
                                          ),
                                          foregroundColor: i == _teleplayIndex
                                              ? MaterialStateProperty.all<
                                                  Color>(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                )
                                              : MaterialStateProperty.all<
                                                  Color>(
                                                  Theme.of(context)
                                                      .disabledColor,
                                                ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _teleplayIndex = i;
                                            widget.callback(
                                                _originIndex, _teleplayIndex);
                                          });
                                        },
                                        child: Text(e?.episode ?? ''),
                                      ),
                                    )
                                    .toList(),
                              )
                            : const Center(
                                child: Text('暂无数据'),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
