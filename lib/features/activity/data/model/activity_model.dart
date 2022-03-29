import 'package:activity_app/features/activity/domain/entity/activity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_model.g.dart';

/// Model activity
@JsonSerializable()
class ActivityModel extends Activity {
  static const String route = 'http://www.boredapi.com/api/activity/';

  /// Create instance [ActivityModel].
  ActivityModel({
    required String activity,
    required double accessibility,
    required String type,
    required double participants,
    required double price,
    String? link,
  }) : super(
          accessibility: accessibility,
          activity: activity,
          type: type,
          participants: participants,
          price: price,
          link: link,
        );

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);
}
