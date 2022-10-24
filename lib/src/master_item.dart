import 'package:flutter/material.dart';
import 'package:master_detail_flow/src/typedefs.dart';

/// a base for items
abstract class MasterItemBase {
  /// Default constructor
  const MasterItemBase();
}

/// Describes the configuration for an item in the master list shown as a
/// List Tile.
class MasterItem extends MasterItemBase {
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

/// A master item that acts as a header
class MasterItemHeader extends StatelessWidget implements MasterItemBase {
  /// Creates a header
  const MasterItemHeader({
    required this.child,
    super.key,
  });

  /// The child of
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2,
          child: child,
        ),
      ),
    );
  }
}

/// A divider for the master list
class MasterItemDivider extends StatelessWidget implements MasterItemBase {
  /// Creates a divider
  const MasterItemDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      indent: 12,
      endIndent: 12,
    );
  }
}
