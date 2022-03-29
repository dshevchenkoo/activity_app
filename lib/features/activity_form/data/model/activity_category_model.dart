import 'package:activity_app/features/activity_form/domain/entity/activity_category.dart';
import 'package:flutter/material.dart';

/// Class model for [ActivityCategory] button.
class ActivityCategoryModel extends ActivityCategory {
  /// Create an instance [ActivityCategoryModel].
  ActivityCategoryModel(String name, Color color) : super(name, color);

  /// factory for ActivityCategory
  factory ActivityCategoryModel.fromJson(Map<String, dynamic> json) =>
      ActivityCategoryModel(
        json['name'] as String,
        json['color'] as Color,
      );
}
