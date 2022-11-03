import 'package:flutter/material.dart';
import 'package:master_detail_flow/src/typedefs.dart';

/// A base for items. Implement this in a Widget class to create a custom
/// master item
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
    this.subtitle,
    this.onTap,
    this.leading,
    this.trailing,
  }) : assert(
          detailsBuilder != null || onTap != null,
          'You need to specify at least one of detailsBuilder or onTap.',
        );

  /// The title showed in the list tile
  final String title;

  /// The optional subtitle showed in the list tile
  final String? subtitle;

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

/// A master item that acts as a header..
class MasterItemHeader extends StatelessWidget implements MasterItemBase {
  /// Creates a header
  const MasterItemHeader({
    required this.child,
    this.cardPadding,
    this.cardElevation = 2,
    super.key,
  });

  /// The child of
  final Widget child;

  /// A padding to be put arround the card.
  ///
  /// Defaults to `EdgeInsets.symmetric(horizontal: 16, vertical: 8,)`.
  final EdgeInsetsGeometry? cardPadding;

  /// The card elevation.
  ///
  /// Defaults to 2.
  final double cardElevation;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 200,
      ),
      child: Card(
        margin: cardPadding ??
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
        elevation: cardElevation,
        child: child,
      ),
    );
  }
}

/// A divider for the master list. That get's its indent from the listTileTheme
/// in order to arrange with the list tiles
class MasterItemDivider extends StatelessWidget implements MasterItemBase {
  /// Creates a divider
  const MasterItemDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final ListTileThemeData listTileTheme = ListTileTheme.of(context);
    return Divider(
      indent: listTileTheme.contentPadding?.horizontal ?? 16,
      endIndent: listTileTheme.contentPadding?.horizontal ?? 16,
    );
  }
}
