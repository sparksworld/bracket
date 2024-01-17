// import 'package:provider/provider.dart';

import '/plugins.dart';
import '/views/home/index.dart';
import '/views/login.dart';
import '/views/splash.dart';
import '/views/unknown.dart';
import 'views/theme/index.dart';
import 'views/detail/index.dart';

class SparkRoute {
  bool? noAuth;
  Widget Function(BuildContext, {Map? arguments}) builder;

  SparkRoute({required this.builder, this.noAuth});
}

class MYRouter {
  static String homePagePath = '/';
  static String splashPagePath = '/splash_page';
  static String detailPagePath = '/detail_page';
  static String loginPagePath = '/login_page';
  static String aboutPagePath = '/about_page';
  static String unknownPagePath = '/unknown_page';
  static String settingPagePath = '/setting_page';
  static String themePagePath = '/theme_page';

  static String get initialRoute => homePagePath;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Map<String, SparkRoute> routeTables = {
    //启动页
    splashPagePath: SparkRoute(
        noAuth: true, builder: (_, {arguments}) => const SplashPage()),
    //登录
    loginPagePath: SparkRoute(
        noAuth: false, builder: (_, {arguments}) => const LoginPage()),
    //首页
    homePagePath: SparkRoute(builder: (_, {arguments}) => const HomePage()),
    detailPagePath: SparkRoute(
      builder: (_, {arguments}) => DetailPage(arguments: arguments),
    ),

    //设置
    // settingPagePath: SparkRoute(builder: Setting()),

    //主题
    themePagePath: SparkRoute(builder: (_, {arguments}) => const ThemePage()),
    // 未知
    unknownPagePath:
        SparkRoute(builder: (_, {arguments}) => const UnknownPage()),
  };

  ///路由拦截
  static MaterialPageRoute generateRoute<T extends Object>(
      RouteSettings settings) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (_) {
        Map? arguments = settings.arguments as Map?;
        final profile = _.watch<Profile>();
        String? name = settings.name;
        SparkRoute? routeData = routeTables[name];
        Widget Function(BuildContext, {Map? arguments})? builder =
            routeData?.builder;

        // Map<String, dynamic>? profile =
        //     PreferenceUtils.getMap<Map<String, dynamic>>('profile');

        if (routeData?.noAuth != true) {
          if (profile.user?.userToken == null) {
            // MYRouter.navigatorKey.currentState?.pushNamedAndRemoveUntil(
            //     MYRouter.loginPagePath, (route) => false);
            builder = routeTables[loginPagePath]?.builder;
          }
        }

        builder ??= routeTables[unknownPagePath]?.builder;

        return builder!(_, arguments: arguments);
      },
      settings: settings,
    );

    return route;
  }

  static RouteFactory get unknownRoute => (settings) {
        return MaterialPageRoute(
          builder: (BuildContext _) => routeTables[unknownPagePath]!
              .builder(_, arguments: settings.arguments as Map?),
        );
      };
}