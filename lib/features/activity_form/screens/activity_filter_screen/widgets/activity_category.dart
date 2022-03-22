import 'package:activity_app/core/extension/string_extension.dart';
import 'package:activity_app/features/activity_form/domain/entity/activity_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivityCategoryBox extends StatelessWidget {
  /// instance [ActivityCategory]
  final ActivityCategory activeCategory;

  /// Create instance [ActivityCategory]
  const ActivityCategoryBox(this.activeCategory, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: 64,
      child: Center(
        child: Column(
          children: [
            Container(
              height: 64,
              width: 64,
              alignment: Alignment.center,
              color: !activeCategory.isSelected
                  ? activeCategory.color
                  : Colors.white,
              child: SvgPicture.asset(
                activeCategory.iconPath,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              activeCategory.name.capitalize(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
