import 'package:activity_app/features/activity/domain/entity/activity.dart';
import 'package:activity_app/features/activity/domain/usecase/fetch_activity.dart';
import 'package:activity_app/features/activity_form/domain/dto/activity_params_dto.dart';
import 'package:elementary/elementary.dart';

/// Default Elementary model for Activity module
class ActivityScreenModel extends ElementaryModel {
  final FetchActivity fetchActivity;

  ActivityScreenModel(ErrorHandler errorHandler, this.fetchActivity)
      : super(errorHandler: errorHandler);

  Future<List<Activity>> loadActivity(ActivityParamsDto activityParams) async {
    final activity = await fetchActivity(activityParams: activityParams);
    return activity;
  }
}
