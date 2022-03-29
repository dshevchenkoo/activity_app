import 'package:activity_app/features/activity/domain/entity/activity.dart';
import 'package:activity_app/features/activity_form/domain/dto/activity_params_dto.dart';

/// Abstract repository for [Activity].
abstract class ActivityRepository {
  Future<List<Activity>> fetchActivity({ActivityParamsDto? activityParams});
}
