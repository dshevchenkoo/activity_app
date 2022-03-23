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
  Future<List<Activity>> fetchActivity({
    ActivityParamsDto? activityParams,
  }) async {
    final result = <Activity>[];
    final activityResponseList = <Future<Response<Map<String, dynamic>>>>[];
    final queryParameters = <String, dynamic>{
      'price': activityParams!.price,
      'accessibility': activityParams.accessibility,
      'participants': activityParams.participants,
    }..removeWhere((key, dynamic value) => value == null);

    for (final category in activityParams.activityCategories) {
      queryParameters['activityCategories'] = category;
      activityResponseList.add(dio.get<Map<String, dynamic>>(
        ActivityModel.route,
        queryParameters: queryParameters,
      ));
    }

    final results = (await Future.wait(activityResponseList)).where((response) {
      return response.data != null && response.data!['error'] == null;
    });

    if (results.isEmpty) {
      throw Exception('Активность по выбранным параметрам не найдена');
    } else {
      return results.map((e) => ActivityModel.fromJson(e.data!)).toList();
    }
  }
}
