import 'package:activity_app/assets/colors/colors.dart';
import 'package:activity_app/features/activity_form/data/model/activity_category_model.dart';
import 'package:activity_app/features/activity_form/domain/entity/activity_category.dart';
import 'package:activity_app/features/activity_form/screens/activity_filter_screen/widgets/activity_category.dart';
import 'package:flutter/material.dart';

/// Class for choose category Activity
class ActivityCategoryDialog extends StatefulWidget {
  /// List of categories.
  late List<ActivityCategory> _activityCategories;

  /// Create an instance [ActivityCategoryDialog].
  ActivityCategoryDialog(List<ActivityCategory> activityCategories, {Key? key})
      : _activityCategories = activityCategories,
        super(key: key);

  @override
  _ActivityCategoryDialogState createState() => _ActivityCategoryDialogState();
}

class _ActivityCategoryDialogState extends State<ActivityCategoryDialog> {
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
                  children: widget._activityCategories.map((activity) {
                    return InkWell(
                      child: ActivityCategoryBox(activity),
                      onTap: () {
                        widget
                            ._activityCategories[
                                widget._activityCategories.indexOf(activity)]
                            .isSelected = !activity.isSelected;

                        setState(() {});
                      },
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
                  onPressed: widget._activityCategories
                          .where((element) => element.isSelected)
                          .isNotEmpty
                      ? () {
                          final selectedCategories = widget._activityCategories
                              .where((element) => element.isSelected)
                              .toList() as List<ActivityCategoryModel>;
                          Navigator.of(context).pop<List<ActivityCategory>>(
                            selectedCategories,
                          );
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
