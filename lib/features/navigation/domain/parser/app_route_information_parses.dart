import 'package:activity_app/features/navigation/domain/entity/app_coordinate.dart';
import 'package:activity_app/features/navigation/domain/entity/coordinate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// [RouteInformationParser] implementation.
/// Passed in the routeInformationParser field in [MaterialApp.router].
class AppRouteInformationParser extends RouteInformationParser<Coordinate> {
  @override
  Future<Coordinate> parseRouteInformation(RouteInformation routeInformation) =>
      SynchronousFuture(AppCoordinate.initScreen);
}
