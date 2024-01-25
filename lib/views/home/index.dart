import '/plugins.dart';
import './tabs/recommend/index.dart' show RecommendTab;
import './tabs/user_center.dart' show UserCenterTab;
import './tabs/classify/index.dart' show ClassifyTab;

class HomePage extends StatefulWidget {
  final String? arguments;
  const HomePage({super.key, this.arguments});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> _pages = [];
  final _pageController = PageController();

  void _pageChanged(int index) {
    setState(() {
      if (_currentIndex != index) _currentIndex = index;
    });
  }

  void onTabTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  void initState() {
    if (mounted) {
      _currentIndex = 0;
      _pages = [
        const RecommendTab(),
        const ClassifyTab(),
        const UserCenterTab(),
      ];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (bool willpop) {
        if (willpop) return;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return MyDialog(
              title: '提示',
              content: '是否退出应用111？',
              onConfirm: () async {
                SystemNavigator.pop();
              },
            );
          },
        );
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex, //New
          onTap: onTabTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '推荐',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie_filter),
              label: '分类',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '我的',
            )
          ],
        ),
        body: PageView.builder(
          controller: _pageController,
          // physics: NeverScrollableScrollPhysics(),
          onPageChanged: _pageChanged,
          itemCount: _pages.length,
          itemBuilder: (context, index) => OrientationBuilder(
            builder: (context, orientation) {
              return (_pages[index]);
            },
          ),
        ),
      ),
    );
  }
}
