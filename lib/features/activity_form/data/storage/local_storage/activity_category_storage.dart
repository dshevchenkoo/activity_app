import 'package:activity_app/assets/colors/colors.dart';
import 'package:activity_app/features/activity_form/data/storage/local_storage/activity_category_enum.dart';
import 'package:activity_app/features/activity_form/domain/entity/activity_category.dart';
import 'package:activity_app/features/activity_form/domain/storage/local/activity_category_storage.dart';

/// Storage for get json [ActivityCategory]
class ActivityCategoryLocalStorage implements ActivityCategoryStorage {
  final _mapActivityCategoryColor = {
    'education': educationColor,
    'recreational': recreationalColor,
    'social': socialColor,
    'diy': diyColor,
    'charity': charityColor,
    'cooking': cookingColor,
    'relaxation': relaxationColor,
    'music': musicColor,
    'busywork': busyworkColor,
  };

  /// Getter for activity categories.
  List<Map<String, dynamic>> get activityCategories =>
      _generateListActivityCategory()
          .map((e) => {
                'name': e,
                'color': _mapActivityCategoryColor[e]!,
              })
          .toList();

  Iterable<String> _generateListActivityCategory() sync* {
    for (final category in ActivityCategoryEnum.values) {
      yield category.name;
    }
  }
}
