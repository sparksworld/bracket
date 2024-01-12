import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

class ThemeProvider {
  BuildContext context;
  Color sourceColor;

  ThemeProvider(this.context, this.sourceColor);

  final pageTransitionsTheme = const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );

  Color blend(Color targetColor) {
    return Color(
      Blend.harmonize(
        targetColor.value,
        sourceColor.value,
      ),
    );
  }

  Color source(Color? target) {
    Color source = sourceColor;
    if (target != null) {
      source = blend(target);
    }
    return source;
  }

  ColorScheme colors(Brightness brightness) {
    return ColorScheme.fromSeed(
      seedColor: sourceColor,
      brightness: brightness,
      // background: ,
    );
  }

  ShapeBorder get shapeMedium => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      );

  CardTheme cardTheme() {
    return CardTheme(
      // elevation: 0,
      shape: shapeMedium,
      clipBehavior: Clip.antiAlias,
    );
  }

  ListTileThemeData listTileTheme(ColorScheme colors) {
    return ListTileThemeData(
      shape: shapeMedium,
      selectedColor: colors.secondary,
    );
  }

  AppBarTheme appBarTheme(ColorScheme colors) {
    return AppBarTheme(
      // elevation: 0,
      backgroundColor: colors.surface,
      foregroundColor: colors.onSurface,
    );
  }

  TabBarTheme tabBarTheme(ColorScheme colors) {
    return TabBarTheme(
      labelColor: colors.secondary,
      unselectedLabelColor: colors.onSurfaceVariant,
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colors.secondary,
            width: 2,
          ),
        ),
      ),
    );
  }

  BottomAppBarTheme bottomAppBarTheme(ColorScheme colors) {
    return BottomAppBarTheme(
      color: colors.surface,
      // elevation: 0,
    );
  }

  BottomNavigationBarThemeData bottomNavigationBarTheme(ColorScheme colors) {
    return BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: colors.surfaceVariant,
      selectedItemColor: colors.onSurface,
      unselectedItemColor: colors.onSurfaceVariant,
      // elevation: 0,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    );
  }

  NavigationRailThemeData navigationRailTheme(ColorScheme colors) {
    return const NavigationRailThemeData();
  }

  DrawerThemeData drawerTheme(ColorScheme colors) {
    return DrawerThemeData(
      backgroundColor: colors.surface,
    );
  }

  ThemeData light() {
    final selfColor = colors(Brightness.light);
    return ThemeData.light().copyWith(
      primaryColor: sourceColor,
      pageTransitionsTheme: pageTransitionsTheme,
      colorScheme: selfColor,
      appBarTheme: appBarTheme(selfColor),
      cardTheme: cardTheme(),
      listTileTheme: listTileTheme(selfColor),
      bottomAppBarTheme: bottomAppBarTheme(selfColor),
      bottomNavigationBarTheme: bottomNavigationBarTheme(selfColor),
      navigationRailTheme: navigationRailTheme(selfColor),
      tabBarTheme: tabBarTheme(selfColor),
      drawerTheme: drawerTheme(selfColor),
      scaffoldBackgroundColor: selfColor.background,
    );
  }

  ThemeData dark() {
    final selfColor = colors(Brightness.dark);
    return ThemeData.dark().copyWith(
      primaryColor: sourceColor,
      pageTransitionsTheme: pageTransitionsTheme,
      colorScheme: selfColor,
      appBarTheme: appBarTheme(selfColor),
      cardTheme: cardTheme(),
      listTileTheme: listTileTheme(selfColor),
      bottomAppBarTheme: bottomAppBarTheme(selfColor),
      bottomNavigationBarTheme: bottomNavigationBarTheme(selfColor),
      navigationRailTheme: navigationRailTheme(selfColor),
      tabBarTheme: tabBarTheme(selfColor),
      drawerTheme: drawerTheme(selfColor),
      scaffoldBackgroundColor: selfColor.background,
    );
  }

  ThemeData theme() {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.light ? light() : dark();
  }
}

class ThemeSettings {
  ThemeSettings({
    required this.sourceColor,
    required this.themeMode,
  });

  final Color sourceColor;
  final ThemeMode themeMode;
}
