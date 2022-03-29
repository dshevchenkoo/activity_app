import 'package:flutter/material.dart';

/// class dto for ActivityCategory button.
class ActivityCategory {
  /// name of [ActivityCategory].
  final String name;

  /// color of [ActivityCategory].
  final Color color;

  /// icon path [ActivityCategory].
  late final String iconPath;

  /// type for select/unselect category
  bool isSelected = false;

  /// Create an instance [ActivityCategory].
  ActivityCategory(this.name, this.color) : iconPath = 'assets/icons/$name.svg';

  /// Function for copy object ActivityCategory.
  ActivityCategory copyWith({String? name, Color? color}) => ActivityCategory(
        name ?? this.name,
        color ?? this.color,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityCategory &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          color == other.color &&
          iconPath == other.iconPath &&
          isSelected == other.isSelected;

  @override
  int get hashCode =>
      name.hashCode ^ color.hashCode ^ iconPath.hashCode ^ isSelected.hashCode;
}
