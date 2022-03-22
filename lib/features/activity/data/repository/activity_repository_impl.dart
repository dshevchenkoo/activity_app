import 'package:activity_app/features/activity/domain/entity/activity.dart';
import 'package:activity_app/features/activity/domain/repository/activity_repository.dart';
import 'package:activity_app/features/activity/domain/storage/activity_storage.dart';
import 'package:activity_app/features/activity_form/domain/dto/activity_params_dto.dart';

/// [ActivityRepository] implementation.
class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityStorage activityStorage;

  /// Create instance [ActivityRepositoryImpl]
  ActivityRepositoryImpl(this.activityStorage);

  @override
  Future<List<Activity>> fetchActivity(
      {ActivityParamsDto? activityParams}) async {
    final activity =
        await activityStorage.fetchActivity(activityParams: activityParams);
    return activity;
  }
}
