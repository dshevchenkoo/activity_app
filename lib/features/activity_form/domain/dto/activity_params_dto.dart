/// Class dto for request
class ActivityParamsDto {
  /// activity categories
  final List<String> activityCategories;

  /// price
  final double price;

  /// accessibility
  final double accessibility;

  /// participants
  final int participants;

  /// Create instance [ActivityParamsDto]
  ActivityParamsDto({
    required this.activityCategories,
    required this.price,
    required this.accessibility,
    required this.participants,
  });
}
