// import 'package:provider/provider.dart';
import '/plugins.dart';
import '/views/home/index.dart';
import '/views/login.dart';
import '/views/splash.dart';
import '/views/unknown.dart';
import 'views/setting/index.dart';
import 'views/setting/theme_page.dart';

class SparkRoute {
  bool? noAuth;
  Widget builder;

  SparkRoute({required this.builder, this.noAuth});
}

class MYRouter {
  static String homePath = '/';
  static String splashPath = '/splash';
  static String loginPath = '/login';
  static String aboutPath = '/about';
  static String unknownPath = '/unknown';
  static String settingPath = '/setting';
  static String themePagePath = '/theme_page';

  static String get initialRoute => homePath;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Map<String, SparkRoute> routeTables = {
    //启动页
    splashPath: SparkRoute(noAuth: true, builder: const Splash()),
    //登录
    loginPath: SparkRoute(noAuth: false, builder: const Login()),
    //首页
    homePath: SparkRoute(builder: const Home()),

    //设置
    settingPath: SparkRoute(builder: Setting()),

    //主题
    themePagePath: SparkRoute(builder: ThemePage()),
    // 未知
    unknownPath: SparkRoute(builder: const Unknown()),
  };

  ///路由拦截
  static Route generateRoute<T extends Object>(RouteSettings settings) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (_) {
        final profile = _.watch<Profile>();
        String? name = settings.name;
        SparkRoute? routeData = routeTables[name];
        Widget? builder = routeData?.builder;

        // Map<String, dynamic>? profile =
        //     PreferenceUtils.getMap<Map<String, dynamic>>('profile');

        if (routeData?.noAuth != true) {
          if (profile.user?.userToken == null) {
            builder = const Login();
          }
        }

        builder ??= const Unknown();

        return builder;
      },
      settings: settings,
    );

    return route;
  }

  static RouteFactory get unknownRoute => (settings) {
        print('dwadawdawdw=> ${settings.name}');
        return MaterialPageRoute(builder: (_) => const Unknown());
      };
}
