import 'package:activity_app/features/activity/data/model/activity_model.dart';
import 'package:activity_app/features/activity/domain/entity/activity.dart';
import 'package:activity_app/features/activity/domain/storage/activity_storage.dart';
import 'package:activity_app/features/activity_form/domain/dto/activity_params_dto.dart';
import 'package:dio/dio.dart';

/// Remote storage for use network operation.
class ActivityRemoteStorage implements ActivityStorage {
  /// Endpoint for request.
  final Dio dio;

  /// Create instance [ActivityRemoteStorage].
  ActivityRemoteStorage({
    required this.dio,
  });

  @override
  Future<List<Activity>> fetchActivity(
      {ActivityParamsDto? activityParams}) async {
    List<Activity> result = [];
    final queryParameters = <String, dynamic>{
      if (activityParams?.price != null) 'price': activityParams!.price,
      if (activityParams?.accessibility != null)
        'accessibility': activityParams?.accessibility,
      if (activityParams?.participants != null)
        'participants': activityParams?.participants,
    };

    for (var i = 0; i < activityParams!.activityCategories.length; i++) {
      queryParameters['activityCategories'] =
          activityParams.activityCategories[i];
      var response = await dio.get<Map<String, dynamic>>(
        ActivityModel.route,
        queryParameters: queryParameters,
      );
      if (response.data != null && response.data!['error'] != null) {
        throw Exception(response.data!['error']);
      }
      result.add(ActivityModel.fromJson(response.data!));
    }

    return result;
  }
}
