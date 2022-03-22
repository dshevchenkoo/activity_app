import 'package:activity_app/features/activity/domain/entity/activity.dart';
import 'package:activity_app/features/activity/domain/repository/activity_repository.dart';
import 'package:activity_app/features/activity_form/domain/dto/activity_params_dto.dart';

/// Usecase for fetch activity.
class FetchActivity {
  /// Repository for fetch activity.
  final ActivityRepository repository;
  final ActivityParamsDto? activityParams;

  /// Create an instance [FetchActivity].
  FetchActivity(
    this.repository, {
    this.activityParams,
  });

  /// Call function for call instance by varible.
  Future<List<Activity>> call({ActivityParamsDto? activityParams}) {
    return repository.fetchActivity(activityParams: activityParams);
  }
}
