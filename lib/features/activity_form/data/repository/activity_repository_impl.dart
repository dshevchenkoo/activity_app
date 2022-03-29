import 'package:activity_app/features/activity_form/data/model/activity_category_model.dart';
import 'package:activity_app/features/activity_form/domain/repository/activity_category_repository.dart';
import 'package:activity_app/features/activity_form/domain/storage/local/activity_category_storage.dart';

/// Implementation [ActivityCategoryRepository]
class ActivityCategoryRepositoryImpl implements ActivityCategoryRepository {
  /// Activity category storage.
  final ActivityCategoryStorage activityCategoryStorage;

  /// Create an instance [ActivityCategoryRepositoryImpl].
  ActivityCategoryRepositoryImpl(this.activityCategoryStorage);

  @override
  List<ActivityCategoryModel> getActivityCategories() {
    return activityCategoryStorage.activityCategories
        .map(
          (json) => ActivityCategoryModel.fromJson(json),
        )
        .toList();
  }
}
