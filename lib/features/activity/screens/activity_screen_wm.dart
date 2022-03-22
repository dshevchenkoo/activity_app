import 'package:activity_app/features/activity/domain/entity/activity.dart';
import 'package:activity_app/features/activity/screens/activity_screen.dart';
import 'package:activity_app/features/activity/screens/activity_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

abstract class IActivityScreenWidgetModel extends IWidgetModel {
  ListenableState<EntityState<List<Activity>>> get activityState;

  String getSvgPath(Activity activity);

  String price(Activity activity);

  String members(Activity activity);
}

ActivityWidgetModel defaultActivityWidgetModelFactory(BuildContext context) {
  return ActivityWidgetModel(
    context.read<ActivityScreenModel>(),
  );
}

/// Default widget model for ActivityWidget
class ActivityWidgetModel
    extends WidgetModel<ActivityScreen, ActivityScreenModel>
    implements IActivityScreenWidgetModel {
  late final EntityStateNotifier<List<Activity>> _activityController;

  @override
  void initWidgetModel() {
    _activityController = EntityStateNotifier();
    initActivity();
  }

  @override
  String price(Activity activity) => "\$" * (activity.price * 5).toInt();

  @override
  String members(Activity activity) => '${(activity.participants).toInt()}';

  @override
  String getSvgPath(Activity activity) => 'assets/icons/${activity.type}.svg';

  @override
  ListenableState<EntityState<List<Activity>>> get activityState =>
      _activityController;

  Future<void> initActivity() async {
    _activityController.loading();
    try {
      final activity = await model.loadActivity(widget.activityParams);
      _activityController.content(activity);
    } catch (e) {
      _activityController.error((e as Exception));
    }
  }

  @override
  void dispose() {
    _activityController.dispose();
    super.dispose();
  }

  ActivityWidgetModel(ActivityScreenModel model) : super(model);
}
