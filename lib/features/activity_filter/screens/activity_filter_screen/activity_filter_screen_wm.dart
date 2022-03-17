import 'package:activity_app/features/activity_filter/screens/activity_filter_screen/activity_filter_screen.dart';
import 'package:activity_app/features/activity_filter/screens/activity_filter_screen/activity_filter_screen_model.dart';
import 'package:activity_app/features/activity_filter/screens/activity_filter_screen/widgets/activity_category_dialog.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// Interface of [ActivityFilterScreenWidgetModel].
abstract class IActivityFilterScreenWidgetModel extends IWidgetModel {
  /// Description for tooltip.
  String get activityTooltip;

  /// Accessibility getter.
  ListenableState<EntityState<double>> get accessibility;

  /// Count of dollars for big or small [price].
  ListenableState<EntityState<int>> get dollarsCount;

  /// Price value.
  ListenableState<EntityState<double>> get price;

  /// Value of size for [dollarsCount].
  ListenableState<EntityState<double>> get dollarsSize;

  /// Count of participants.
  ListenableState<EntityState<int>> get participants;

  /// Callback function on remove [participants] element.
  Function()? get onRemoveParticipant;

  /// Callback function on add [participants] element.
  Function()? get onAddParticipant;

  /// Percent of [accessibility].
  int get accessibilityPercent;

  /// Show dialog for select category.
  void showActivityCategoryDialog();

  /// Event by changed [accessibility] param.
  void onChangedAccessibility(double value);

  /// Event by changed [price] param.
  void onChangedPrice(double value);
}

/// Factory for [ActivityFilterScreenModel].
ActivityFilterScreenWidgetModel defaultActivityFilterScreenModelFactory(
  BuildContext context,
) {
  final model = ActivityFilterScreenModel();
  return ActivityFilterScreenWidgetModel(model);
}

/// Default widget model for ActivityFilterScreenWidget
class ActivityFilterScreenWidgetModel
    extends WidgetModel<ActivityFilterScreen, ActivityFilterScreenModel>
    implements IActivityFilterScreenWidgetModel {
  late final String _activityTooltip;
  late final List<String> _activityCategory;
  final EntityStateNotifier<double> _accessibilityController =
      EntityStateNotifier<double>.value(0.0);
  final EntityStateNotifier<double> _priceController =
      EntityStateNotifier<double>.value(0.0);
  final EntityStateNotifier<double> _dollarsSizeController =
      EntityStateNotifier<double>.value(0.0);
  final EntityStateNotifier<int> _dollarsCountController =
      EntityStateNotifier<int>.value(0);
  final EntityStateNotifier<int> _participantsController =
      EntityStateNotifier<int>.value(1);

  @override
  String get activityTooltip => _activityTooltip;

  @override
  ListenableState<EntityState<double>> get accessibility =>
      _accessibilityController;

  @override
  ListenableState<EntityState<int>> get participants => _participantsController;

  @override
  ListenableState<EntityState<double>> get price => _priceController;

  @override
  ListenableState<EntityState<double>> get dollarsSize =>
      _dollarsSizeController;

  @override
  ListenableState<EntityState<int>> get dollarsCount => _dollarsCountController;

  @override
  Function()? get onRemoveParticipant =>
      _participantsController.value!.data! == 1
          ? null
          : () {
              _participantsController
                  .content(_participantsController.value!.data! - 1);
            };

  @override
  Function()? get onAddParticipant => _participantsController.value!.data! == 8
      ? null
      : () {
          _participantsController
              .content(_participantsController.value!.data! + 1);
        };

  @override
  int get accessibilityPercent => (accessibility.value!.data! * 100).toInt();

  /// Create an instance [ActivityFilterScreenWidgetModel].
  ActivityFilterScreenWidgetModel(ActivityFilterScreenModel model)
      : super(model);

  @override
  void initWidgetModel() {
    _activityCategory = _generateListActivityCategory().toList();
    _activityTooltip =
        '\nДоступные категории активности:\n${_activityCategory.map((el) => '• $el').join(';\n')}.\n';
  }

  @override
  void dispose() {
    _accessibilityController.dispose();
    _participantsController.dispose();
    _priceController.dispose();
    _dollarsSizeController.dispose();
    _dollarsCountController.dispose();
    super.dispose();
  }

  @override
  Future<void> showActivityCategoryDialog() async {
    // TODO(dsh) exception
    final List<ActivityCategory>? category =
        await showDialog<List<ActivityCategory>?>(
      useRootNavigator: false,
      context: context,
      builder: (_) {
        return ActivityCategoryDialog(_activityCategory);
      },
    );
  }

  @override
  void onChangedAccessibility(double newValue) {
    _accessibilityController.content(newValue);
  }

  @override
  void onChangedPrice(double newValue) {
    _priceController.content(newValue);

    final dollarsCount = newValue * 5;
    _dollarsCountController.content(dollarsCount.toInt());
    final dollarsSize = newValue * 20;
    _dollarsSizeController.content(dollarsSize);
  }

  Iterable<String> _generateListActivityCategory() sync* {
    for (final category in ActivityCategory.values) {
      yield category.name;
    }
  }
}

/// Enum of [ActivityCategory].
enum ActivityCategory {
  /// Category education of [ActivityCategory].
  education,

  /// Category recreational of [ActivityCategory].
  recreational,

  /// Category social of [ActivityCategory].
  social,

  /// Category diy of [ActivityCategory].
  diy,

  /// Category charity of [ActivityCategory].
  charity,

  /// Category cooking of [ActivityCategory].
  cooking,

  /// Category relaxation of [ActivityCategory].
  relaxation,

  /// Category music of [ActivityCategory].
  music,

  /// Category busywork of [ActivityCategory].
  busywork,
}
