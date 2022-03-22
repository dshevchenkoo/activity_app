import 'package:activity_app/features/activity_form/domain/dto/activity_params_dto.dart';
import 'package:activity_app/features/activity_form/domain/entity/activity_category.dart';
import 'package:activity_app/features/activity_form/screens/activity_filter_screen/activity_filter_screen.dart';
import 'package:activity_app/features/activity_form/screens/activity_filter_screen/activity_filter_screen_model.dart';
import 'package:activity_app/features/activity_form/screens/activity_filter_screen/widgets/activity_category_dialog.dart';
import 'package:activity_app/features/app/di/app_scope.dart';
import 'package:activity_app/features/navigation/domain/entity/app_coordinate.dart';
import 'package:activity_app/features/navigation/service/coordinator.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Interface of [ActivityFilterScreenWidgetModel].
abstract class IActivityFilterScreenWidgetModel extends IWidgetModel {
  /// Description for tooltip.
  String get activityTooltip;

  /// Accessibility getter.
  ListenableState<EntityState<double>> get accessibilityState;

  /// Count of dollars for big or small [priceState].
  ListenableState<EntityState<int>> get dollarsCountState;

  /// Price value.
  ListenableState<EntityState<double>> get priceState;

  /// Value of size for [dollarsCountState].
  ListenableState<EntityState<double>> get dollarsSizeState;

  /// Count of participants.
  ListenableState<EntityState<int>> get participantsState;

  /// Text input state.
  ListenableState<EntityState<String>> get activityCategoryState;

  /// Callback function on remove [participantsState] element.
  Function()? get onRemoveParticipant;

  /// Callback function on add [participantsState] element.
  Function()? get onAddParticipant;

  /// Percent of [accessibilityState].
  int get accessibilityPercent;

  /// Text Controller for input activity category.
  TextEditingController get activityCategoryTextController;

  /// Function when onPressed action.
  void Function()? get next;

  /// Function when onChanged ActivityCategory text field action.
  void Function(String)? get onChangedActivityCategory;

  /// Show dialog for select category.
  void showActivityCategoryDialog();

  /// Event by changed [accessibilityState] param.
  void onChangedAccessibility(double value);

  /// Event by changed [priceState] param.
  void onChangedPrice(double value);
}

/// Factory for [ActivityFilterScreenModel].
ActivityFilterScreenWidgetModel defaultActivityFilterScreenModelFactory(
  BuildContext context,
) {
  final model = context.read<ActivityFilterScreenModel>();
  final coordinator =
      Provider.of<IAppScope>(context, listen: false).coordinator;
  return ActivityFilterScreenWidgetModel(model, coordinator);
}

/// Default widget model for ActivityFilterScreenWidget
class ActivityFilterScreenWidgetModel
    extends WidgetModel<ActivityFilterScreen, ActivityFilterScreenModel>
    implements IActivityFilterScreenWidgetModel {
  late final String _activityTooltip;
  late final List<ActivityCategory> _activityCategory;
  late final TextEditingController _activityCategoryTextController;
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
  final EntityStateNotifier<String> _activityCategoryController =
      EntityStateNotifier<String>.value('');

  late final Coordinator _coordinator;

  @override
  String get activityTooltip => _activityTooltip;

  @override
  ListenableState<EntityState<double>> get accessibilityState =>
      _accessibilityController;

  @override
  ListenableState<EntityState<int>> get participantsState =>
      _participantsController;

  @override
  ListenableState<EntityState<double>> get priceState => _priceController;

  @override
  ListenableState<EntityState<double>> get dollarsSizeState =>
      _dollarsSizeController;

  @override
  ListenableState<EntityState<int>> get dollarsCountState =>
      _dollarsCountController;

  @override
  ListenableState<EntityState<String>> get activityCategoryState =>
      _activityCategoryController;

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
  int get accessibilityPercent =>
      (accessibilityState.value!.data! * 100).toInt();

  @override
  TextEditingController get activityCategoryTextController =>
      _activityCategoryTextController;

  @override
  void Function()? get next => _activityCategoryTextController.text.isEmpty
      ? null
      : () {
          try {
            _coordinator.navigate(
              context,
              AppCoordinate.activityScreen,
              arguments: ActivityParamsDto(
                price: _priceController.value!.data!,
                accessibility: _accessibilityController.value!.data!,
                participants: _participantsController.value!.data!,
                activityCategories:
                    _activityCategoryTextController.text.split(','),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Провертье правильность введенных данных"),
              ),
            );
          }
          // Navigator.of(context).pushNamed(routeName);
        };

  @override
  void Function(String p1)? get onChangedActivityCategory => (value) {
        _activityCategoryController
            .content(_activityCategoryTextController.text);
      };

  /// Create an instance [ActivityFilterScreenWidgetModel].
  ActivityFilterScreenWidgetModel(
    ActivityFilterScreenModel model,
    Coordinator coordinator,
  )   : _coordinator = coordinator,
        super(model);

  @override
  void initWidgetModel() {
    _activityCategoryTextController = TextEditingController();
    _activityCategory = model.getActivityCategories();
    _activityTooltip =
        '\nДоступные категории активности:\n${_activityCategory.map((el) => '• ${el.name}').join(';\n')}.\n';
  }

  @override
  void dispose() {
    _activityCategoryTextController.dispose();
    _accessibilityController.dispose();
    _participantsController.dispose();
    _priceController.dispose();
    _dollarsSizeController.dispose();
    _dollarsCountController.dispose();
    _activityCategoryController.dispose();
    super.dispose();
  }

  @override
  Future<void> showActivityCategoryDialog() async {
    final category = await showDialog<List<ActivityCategory>?>(
      useRootNavigator: false,
      context: context,
      builder: (_) {
        return ActivityCategoryDialog(_activityCategory);
      },
    );
    _activityCategoryTextController.text =
        category?.map((e) => e.name).join(',') ?? '';
    _activityCategoryController.content(_activityCategoryTextController.text);
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
}
