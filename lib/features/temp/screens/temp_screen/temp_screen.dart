import 'package:activity_app/features/activity_form/screens/activity_filter_screen/activity_filter_screen.dart';
import 'package:activity_app/features/temp/screens/temp_screen/temp_screen_widget_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// Initialization screens (this can be a HomeScreen or SplashScreen for example).
class TempScreen extends ElementaryWidget<TempScreenWidgetModel> {
  /// Create an instance [TempScreen].
  const TempScreen({
    Key? key,
    WidgetModelFactory wmFactory = initScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(TempScreenWidgetModel wm) {
    return const ActivityFilterScreen();
  }
}
