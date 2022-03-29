import 'package:activity_app/assets/colors/colors.dart';
import 'package:activity_app/assets/themes/text_style.dart';
import 'package:activity_app/config/app_config.dart';
import 'package:activity_app/config/debug_options.dart';
import 'package:activity_app/config/environment/environment.dart';
import 'package:activity_app/core/util/default_error_handler.dart';
import 'package:activity_app/features/activity/di/activity_scope.dart';
import 'package:activity_app/features/activity/screens/activity_screen_model.dart';
import 'package:activity_app/features/activity_form/di/activity_form_scope.dart';
import 'package:activity_app/features/activity_form/screens/activity_filter_screen/activity_filter_screen.dart';
import 'package:activity_app/features/activity_form/screens/activity_filter_screen/activity_filter_screen_model.dart';
import 'package:activity_app/features/app/di/app_scope.dart';
import 'package:activity_app/features/common/widgets/di_scope/di_scope.dart';
import 'package:activity_app/features/navigation/domain/delegate/app_router_delegate.dart';
import 'package:activity_app/features/navigation/domain/entity/app_coordinate.dart';
import 'package:activity_app/features/navigation/domain/parser/app_route_information_parses.dart';
import 'package:activity_app/features/navigation/service/coordinator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

/// App widget.
class App extends StatefulWidget {
  /// Create an instance App.
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late IAppScope _scope;

  @override
  void initState() {
    super.initState();

    _scope = AppScope(applicationRebuilder: _rebuildApplication);

    _setupRouting(_scope.coordinator);
  }

  @override
  Widget build(BuildContext context) {
    return DiScope<IAppScope>(
      key: ObjectKey(_scope),
      factory: () {
        return _scope;
      },
      child: MultiProvider(
        providers: [
          Provider<ActivityScreenModel>(
            create: (_) => ActivityScreenModel(
              DefaultErrorHandler(),
              ActivityScope(_scope.dio).fetchActivity,
            ),
            // child: const ActivityScreen(activityParams: null,),
          ),
          Provider<ActivityFilterScreenModel>(
            create: (_) => ActivityFilterScreenModel(
              ActivityFormScope().getActivityCategory,
            ),
            child: const ActivityFilterScreen(),
          ),
        ],
        child: MaterialApp.router(
          /// Localization.
          locale: _localizations.first,
          localizationsDelegates: _localizationsDelegates,
          supportedLocales: _localizations,

          /// Debug configuration.
          showPerformanceOverlay: _getDebugConfig().showPerformanceOverlay,
          debugShowMaterialGrid: _getDebugConfig().debugShowMaterialGrid,
          checkerboardRasterCacheImages:
              _getDebugConfig().checkerboardRasterCacheImages,
          checkerboardOffscreenLayers:
              _getDebugConfig().checkerboardOffscreenLayers,
          showSemanticsDebugger: _getDebugConfig().showSemanticsDebugger,
          debugShowCheckedModeBanner:
              _getDebugConfig().debugShowCheckedModeBanner,

          /// This is for navigation.
          routeInformationParser: AppRouteInformationParser(),
          routerDelegate: AppRouterDelegate(_scope.coordinator),

          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: primaryColor,
            ),
            inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(color: textColorPrimary),
              prefixStyle: TextStyle(color: textColorPrimary),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: .5,
                ),
              ),
            ),
            primaryColor: Colors.green,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  textMedium,
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  DebugOptions _getDebugConfig() {
    return Environment<AppConfig>.instance().config.debugOptions;
  }

  void _setupRouting(Coordinator coordinator) {
    coordinator
      ..initialCoordinate = AppCoordinate.initial
      ..registerCoordinates('/', appCoordinates);
  }

  void _rebuildApplication() {
    setState(() {
      _scope = AppScope(applicationRebuilder: _rebuildApplication);
      _setupRouting(_scope.coordinator);
    });
  }
}

// You need to customize for your project.
const _localizations = [Locale('ru', 'RU')];

const _localizationsDelegates = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
