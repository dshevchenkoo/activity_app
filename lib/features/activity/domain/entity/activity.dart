/// Entity for response activity.
abstract class Activity {
  /// Description activity.
  final String activity;

  ///
  final double accessibility;

  /// Type of activity.
  final String type;

  /// Members than can participate activity.
  final double participants;

  /// Price of activity.
  final double price;

  /// Additional link for activity.
  final String? link;

  /// Create instance [Activity]
  Activity({
    required this.activity,
    required this.accessibility,
    required this.type,
    required this.participants,
    required this.price,
    this.link,
  });
}
