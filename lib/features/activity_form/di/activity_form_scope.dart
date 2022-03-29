import 'package:activity_app/features/activity_form/data/repository/activity_repository_impl.dart';
import 'package:activity_app/features/activity_form/data/storage/local_storage/activity_category_storage.dart';
import 'package:activity_app/features/activity_form/domain/repository/activity_category_repository.dart';
import 'package:activity_app/features/activity_form/domain/storage/local/activity_category_storage.dart';
import 'package:activity_app/features/activity_form/domain/usecase/get_activity_categories.dart';

/// Scope of dependencies which need through activity form life.
class ActivityFormScope implements IActivityFormScope {
  @override
  GetActivityCategory get getActivityCategory =>
      GetActivityCategory(_activityCategoryRepository);

  ActivityCategoryRepository get _activityCategoryRepository =>
      ActivityCategoryRepositoryImpl(_activityCategoryStorage);

  ActivityCategoryStorage get _activityCategoryStorage =>
      ActivityCategoryLocalStorage();
}

/// ActivityForm dependencies.
abstract class IActivityFormScope {
  /// usecase for get activity category.
  GetActivityCategory get getActivityCategory;
}
