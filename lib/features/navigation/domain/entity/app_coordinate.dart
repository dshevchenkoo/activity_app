import 'package:activity_app/features/activity/screens/activity_screen.dart';
import 'package:activity_app/features/activity_form/domain/dto/activity_params_dto.dart';
import 'package:activity_app/features/debug/screens/debug_screen/debug_screen.dart';
import 'package:activity_app/features/navigation/domain/entity/coordinate.dart';
import 'package:activity_app/features/temp/screens/temp_screen/temp_screen.dart';

/// A set of routes for the entire app.
class AppCoordinate implements Coordinate {
  /// Initialization screens([TempScreen]).
  static const initScreen = AppCoordinate._('temp');

  /// Debug screens([DebugScreen]).
  static const debugScreen = AppCoordinate._('debug_screen');

  /// Activity screen []
  static const activityScreen = AppCoordinate._('activity_screen');

  /// Initialization screens(it can be any screens).
  static const initial = initScreen;

  final String _value;

  const AppCoordinate._(this._value);

  @override
  String toString() => _value;
}

/// List of main routes of the app.
final Map<AppCoordinate, CoordinateBuilder> appCoordinates = {
  AppCoordinate.initial: (_, __) => const TempScreen(),
  AppCoordinate.debugScreen: (_, __) => const DebugScreen(),
  AppCoordinate.activityScreen: (_, args) => ActivityScreen(
        activityParams: args as ActivityParamsDto,
      ),
};
