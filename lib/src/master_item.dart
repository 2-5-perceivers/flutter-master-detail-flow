import 'package:flutter/material.dart';
import 'package:master_detail_flow/src/typedefs.dart';

/// Describes the configuration for an item in the master list shown as a
/// List Tile.
class MasterItem {
  /// Creates a MasterItem. If you don't provide a detailsBuilder you need to
  /// onTap.
  /// Usage:
  /// ```dart
  /// MasterItem(
  ///   'Item',
  ///   detailsBuilder: (_) => DetailsItem(),
  /// )
  /// ```
  const MasterItem(
    this.title, {
    this.detailsBuilder,
    this.onTap,
    this.leading,
    this.trailing,
  }) : assert(
          detailsBuilder != null || onTap != null,
          'You need to specify at least one of detailsBuilder or onTap.',
        );

  /// The title showed in the list tile
  final String title;

  /// [ListTile.leading] and [ListTile.trailing] corespondents
  final Widget? leading, trailing;

  /// A builder functions that constructs a details page. The details page
  /// should use [MasterDetailsFlowSettings] to adapt and function.
  ///
  /// See:
  ///   * [DetailsItem]
  final DetailsBuilder? detailsBuilder;

  /// An override for the onTap callback so the list tile doesn't open a details
  /// page.
  final GestureTapCallback? onTap;
}
