import 'package:activity_app/features/activity_form/domain/entity/activity_category.dart';
import 'package:activity_app/features/activity_form/domain/usecase/get_activity_categories.dart';
import 'package:elementary/elementary.dart';

/// Default Elementary model for ActivityFilterScreen module
class ActivityFilterScreenModel extends ElementaryModel {
  late final GetActivityCategory _getActivityCategory;

  /// Create an instance [ActivityFilterScreenModel].
  ActivityFilterScreenModel(GetActivityCategory getActivityCategory)
      : _getActivityCategory = getActivityCategory;

  /// return ActivityCategories
  List<ActivityCategory> getActivityCategories() {
    return _getActivityCategory();
  }
}
