import 'package:flutter/material.dart';
import 'package:master_detail_flow/src/models/theme.dart';

/// Provides a [MDThemeData] to the children.
class MDTheme extends InheritedWidget {
  /// Creates a [MDTheme].
  const MDTheme({
    required this.data,
    required super.child,
    super.key,
  });

  /// The [MDThemeData] to provide to the children.
  final MDThemeData data;

  /// Returns the [MDThemeData] from the closest [MDTheme] ancestor.
  static MDThemeData? mayOf(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<MDTheme>();
    return theme?.data;
  }

  @override
  bool updateShouldNotify(MDTheme oldWidget) => data != oldWidget.data;
}
