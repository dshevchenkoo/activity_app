import 'package:activity_app/features/activity/domain/entity/activity.dart';
import 'package:activity_app/features/activity_form/domain/dto/activity_params_dto.dart';

/// Abstract class for activity storage.
abstract class ActivityStorage {
  Future<List<Activity>> fetchActivity({ActivityParamsDto? activityParams});
}
