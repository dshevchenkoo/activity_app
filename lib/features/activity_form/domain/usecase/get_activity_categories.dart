import 'package:activity_app/features/activity_form/domain/entity/activity_category.dart';
import 'package:activity_app/features/activity_form/domain/repository/activity_category_repository.dart';

/// Usecase get activity categories.
class GetActivityCategory {
  /// repository for get activity categories.
  final ActivityCategoryRepository repository;

  /// Create an instance [GetActivityCategory].
  GetActivityCategory(this.repository);

  /// Call function for call instance by varible.
  List<ActivityCategory> call() {
    return repository.getActivityCategories();
  }
}
