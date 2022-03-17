import 'package:activity_app/assets/colors/colors.dart';
import 'package:activity_app/core/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Class for choose category Activity
class ActivityCategoryDialog extends StatefulWidget {
  /// List of categories.
  final List<String> activityCategories;

  /// Create an instance [ActivityCategoryDialog].
  ActivityCategoryDialog(this.activityCategories, {Key? key}) : super(key: key);

  @override
  _ActivityCategoryDialogState createState() => _ActivityCategoryDialogState();
}

class _ActivityCategoryDialogState extends State<ActivityCategoryDialog> {
  /// Mapper name category to [ActivityCategory] object.
  Map<String, ActivityCategory> mapCategoryNameActivityCategory = {
    'education': ActivityCategory(
      'education',
      educationColor,
    ),
    'recreational': ActivityCategory(
      'recreational',
      recreationalColor,
    ),
    'social': ActivityCategory(
      'social',
      socialColor,
    ),
    'diy': ActivityCategory(
      'diy',
      diyColor,
    ),
    'charity': ActivityCategory(
      'charity',
      charityColor,
    ),
    'cooking': ActivityCategory(
      'cooking',
      cookingColor,
    ),
    'relaxation': ActivityCategory(
      'relaxation',
      relaxationColor,
    ),
    'music': ActivityCategory(
      'music',
      musicColor,
    ),
    'busywork': ActivityCategory(
      'busywork',
      busyworkColor,
    ),
  };
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 2.5;
    return Dialog(
      backgroundColor: backgroundDialog,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                right: 20,
              ),
              child: Text(
                'Выберете категорию',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Container(
                height: height,
                child: GridView.count(
                  mainAxisSpacing: 20,
                  crossAxisCount: 3,
                  children: widget.activityCategories.map((e) {
                    final activeCategory = mapCategoryNameActivityCategory[e]!;
                    return SizedBox(
                      height: 64,
                      width: 64,
                      child: Center(
                        child: Column(
                          children: [
                            Ink(
                              decoration: BoxDecoration(
                                color: activeCategory.isSelected
                                    ? Colors.white
                                    : activeCategory.color,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: InkWell(
                                onTap: () {
                                  activeCategory.isSelected =
                                      !activeCategory.isSelected;
                                  setState(() {});
                                },
                                child: Container(
                                  height: 64,
                                  width: 64,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      activeCategory.iconPath,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              e.capitalize(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: mapCategoryNameActivityCategory.values
                          .where((element) => element.isSelected)
                          .isNotEmpty
                      ? () {
                          final selectedCategories =
                              mapCategoryNameActivityCategory.values
                                  .where((element) => element.isSelected)
                                  .toList();
                          // TODO (dsh) exception
                          Navigator.of(context).pop(selectedCategories);
                        }
                      : null,
                  child: const Text(
                    'Выбрать категорию',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// class dto for ActivityCategory button.
class ActivityCategory {
  /// name of [ActivityCategory].
  final String name;

  /// color of [ActivityCategory].
  final Color color;

  /// icon path [ActivityCategory].
  late final String iconPath;

  ///
  bool isSelected = false;

  /// Create an instance [ActivityCategory].
  ActivityCategory(this.name, this.color) : iconPath = 'assets/icons/$name.svg';
}
