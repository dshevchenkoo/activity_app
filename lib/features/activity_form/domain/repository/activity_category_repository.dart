import 'package:activity_app/features/activity_form/domain/entity/activity_category.dart';

/// Abstract repository for [ActivityCategory].
abstract class ActivityCategoryRepository {
  /// Function for get ActivityCategories.
  List<ActivityCategory> getActivityCategories();
}
