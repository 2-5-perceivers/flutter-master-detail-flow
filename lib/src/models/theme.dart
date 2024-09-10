import 'package:flutter/material.dart';

import 'package:master_detail_flow/src/enums/app_bar_size.dart';
import 'package:master_detail_flow/src/typedefs.dart';

/// Defines the visual configuration for the [MDScaffold].
///
/// Use as a parameter for the [MDScaffold] widget or as a parameter for the
/// [MDTheme] widget.
///
/// See:
///   * [MDScaffold]
///   * [MDTheme]
class MDThemeData {
  /// Creates a [MDThemeData].
  MDThemeData({
    this.detailsPanelBorderRadius,
    this.masterPanelWidth,
    this.masterPageAppBarSize,
    this.masterPageListTileTheme,
    this.masterPanelListTileTheme,
    this.noSelectedItemChildBuilder,
    this.transitionAnimationDuration,
    this.detailsPanelBackgroundColor,
  });

  /// The border radius for the details panel.
  final double? detailsPanelBorderRadius;

  /// The width of the master panel when in lateral mode.
  final double? masterPanelWidth;

  /// The size of the app bar in the master page. Affects only the app bar in
  /// page mode.
  final MDAppBarSize? masterPageAppBarSize;

  /// Overrides the master panel list tile theme which is used in lateral mode.
  /// If not provided, the theme will be based on the [ThemeData].
  final ListTileThemeData? masterPanelListTileTheme;

  /// If null the default [ListTileThemeData] will be used when in page mode.
  final ListTileThemeData? masterPageListTileTheme;

  /// A builder for the empty details panel when no item is selected.
  final MDWidgetBuilder? noSelectedItemChildBuilder;

  /// The duration of the transition animation between master and details.
  /// Defaults to 500 milliseconds.
  final Duration? transitionAnimationDuration;

  /// The background color of the details panel.
  final Color? detailsPanelBackgroundColor;

  /// Creates a copy of this [MDThemeData] but with the given fields replaced
  MDThemeData copyWith({
    double? detailsPanelBorderRadius,
    double? masterPanelWidth,
    MDAppBarSize? masterPageAppBarSize,
    ListTileThemeData? masterPanelListTileTheme,
    MDWidgetBuilder? noSelectedItemChildBuilder,
    Duration? transitionAnimationDuration,
    Color? detailsPanelBackgroundColor,
  }) =>
      MDThemeData(
        detailsPanelBorderRadius:
            detailsPanelBorderRadius ?? this.detailsPanelBorderRadius,
        masterPanelWidth: masterPanelWidth ?? this.masterPanelWidth,
        masterPageAppBarSize: masterPageAppBarSize ?? this.masterPageAppBarSize,
        masterPanelListTileTheme:
            masterPanelListTileTheme ?? this.masterPanelListTileTheme,
        noSelectedItemChildBuilder:
            noSelectedItemChildBuilder ?? this.noSelectedItemChildBuilder,
        transitionAnimationDuration:
            transitionAnimationDuration ?? this.transitionAnimationDuration,
        detailsPanelBackgroundColor:
            detailsPanelBackgroundColor ?? this.detailsPanelBackgroundColor,
      );

  @override
  String toString() =>
      'MDThemeData(detailsPanelBorderRadius: $detailsPanelBorderRadius, '
      'masterPanelWidth: $masterPanelWidth, '
      'masterPageAppBarSize: $masterPageAppBarSize, '
      'masterPanelListTileTheme: $masterPanelListTileTheme, '
      'noSelectedItemChildBuilder: $noSelectedItemChildBuilder, '
      'transitionAnimationDuration: $transitionAnimationDuration, '
      'detailsPanelBackgroundColor: $detailsPanelBackgroundColor)';

  @override
  bool operator ==(covariant MDThemeData other) {
    if (identical(this, other)) return true;

    return other.detailsPanelBorderRadius == detailsPanelBorderRadius &&
        other.masterPanelWidth == masterPanelWidth &&
        other.masterPageAppBarSize == masterPageAppBarSize &&
        other.masterPanelListTileTheme == masterPanelListTileTheme &&
        other.noSelectedItemChildBuilder == noSelectedItemChildBuilder &&
        other.transitionAnimationDuration == transitionAnimationDuration &&
        other.detailsPanelBackgroundColor == detailsPanelBackgroundColor;
  }

  @override
  int get hashCode =>
      detailsPanelBorderRadius.hashCode ^
      masterPanelWidth.hashCode ^
      masterPageAppBarSize.hashCode ^
      masterPanelListTileTheme.hashCode ^
      noSelectedItemChildBuilder.hashCode ^
      transitionAnimationDuration.hashCode ^
      detailsPanelBackgroundColor.hashCode;
}
