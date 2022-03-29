import 'package:activity_app/features/temp/screens/temp_screen/temp_screen.dart';
import 'package:activity_app/features/temp/screens/temp_screen/temp_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// Factory for [TempScreenWidgetModel].
TempScreenWidgetModel initScreenWidgetModelFactory(
  BuildContext context,
) {
  final model = TempScreenModel();
  return TempScreenWidgetModel(model);
}

/// Widget model for [TempScreen].
class TempScreenWidgetModel extends WidgetModel<TempScreen, TempScreenModel>
    implements IDebugWidgetModel {
  /// Create an instance [TempScreenWidgetModel].
  TempScreenWidgetModel(TempScreenModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }
}

/// Interface of [TempScreenWidgetModel].
abstract class IDebugWidgetModel extends IWidgetModel {}
