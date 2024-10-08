import '/model/index/data.dart';

import '/plugins.dart';

class ClassifyTab extends StatefulWidget {
  const ClassifyTab({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ClassifyTabState();
  }
}

class _ClassifyTabState extends State<ClassifyTab>
    with AutomaticKeepAliveClientMixin {
  // late TabController _tabController;
  late ScrollController _scrollViewController;
  Data? _data;
  bool _loading = false;
  bool _error = false;

  // List<Content> get _content {
  //   return _data?.content ?? [];
  // }

  Future _fetchData() async {
    setState(() {
      _loading = true;
      _error = false;
    });
    var res = await Api.index(
      context: context,
    );

    if (res != null && res.runtimeType != String) {
      Recommend jsonData = Recommend.fromJson(res);
      setState(() {
        _loading = false;
        _error = false;
        _data = jsonData.data;
      });
    } else {
      // await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _error = true;
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    _fetchData();
    // _tabController = TabController(length: 6, vsync: this);
    _scrollViewController = ScrollController();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    // _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36),
                  ),
                  side: BorderSide(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    width: 4,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                ),
                // foregroundColor: Colors.red,
                pinned: true,
                floating: true,
                expandedHeight: 100.0,
                flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    centerTitle: false,
                    title: const Text(
                      '影片分类',
                    ),
                    background: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          right: 0,
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/header.jpeg',
                                ),
                              ),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(36),
                                bottomRight: Radius.circular(36),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ];
          },
          body: LoadingViewBuilder(
            loading: _loading,
            builder: (_) {
              return _error
                  ? Error(
                      onRefresh: _fetchData,
                    )
                  : _listContent(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _listContent(_) {
    return ListView(
      padding: EdgeInsets.only(
        top: 24,
        bottom: MediaQuery.of(_).padding.bottom,
      ),
      children: [
        Column(
          children: [
            ...?_data?.category?.children!.map(
              (e) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Row(
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                MYRouter.filterPagePath,
                                arguments: {
                                  "pid": e.id,
                                },
                              );
                            },
                            child: Text(
                              e.name ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.fontSize,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.fromLTRB(8, 12, 8, 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Wrap(
                          spacing: 8,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: e.children!
                              .map(
                                (item) => ChoiceChip(
                                  label: Text(item.name ?? ''),
                                  selected: false,
                                  onSelected: (newValue) {
                                    Navigator.of(context).pushNamed(
                                      MYRouter.filterPagePath,
                                      arguments: {
                                        "pid": e.id,
                                        "category": item.id
                                      },
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
