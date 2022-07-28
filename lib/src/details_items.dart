import 'package:flutter/material.dart';

/// A base class for entries in a Material Design MasterDetailsFlow.
///
/// A [MasterDetailFlowItemBase] may represent a title (see
/// [MasterDetailFlowTitle]), a divider (see [MasterDetailFlowDivider]) or a
/// list tile that opens details([MasterDetailFlowItem]).
///
/// See also:
///
///  * [MasterDetailFlowTitle], a master detail flow entry that is a title.
///  * [MasterDetailFlowItem], a list tile that opens details pages.
///  * [MasterDetailFlowDivider], a master detail flow entry that is just a
///  simple divider.
abstract class MasterDetailFlowItemBase {
  /// Abstract const constructor.
  const MasterDetailFlowItemBase({
    required this.selectable,
  });

  /// Defines if this is an item that can open a details page.
  final bool selectable;

  /// This builds the widget that is shown in the master panel. You can override
  /// this to create custom widgets(if you want to create a selectable item
  /// extend MasterDetailFlowItem instead).
  /// [selected] and [onTap] are used only in selectable items.
  Widget buildWidget(BuildContext context,
      {bool selected = false, GestureTapCallback? onTap});
}

/// A widget that can be placed in a MasterDetailFlow master panel with a title
/// and subtitle that opens a details page when tapped.
///
/// ```dart
/// masterItems: [
///   MasterDetailFlowItem(
///       title: Text('Some amazing title'),
///       subtitle: Text('And a subtitle'),
///       showSubtitleOnDetails: true,
///       detailsListChildBuilder: (context, index) =>
///           Text('Child $index'),
///     ),
/// ]
/// ```
///
/// See also:
///
///  * [MasterDetailFlowTitle], a master detail flow entry that is a title.
///  * [MasterDetailFlowDivider], a master detail flow entry that is just a
///  simple divider.
class MasterDetailFlowItem extends MasterDetailFlowItemBase {
  /// Creates a MasterDetailFlowItem.
  const MasterDetailFlowItem({
    required this.title,
    required this.detailsListChildBuilder,
    this.subtitle,
    this.showSubtitleOnDetails = false,
    this.leading,
    this.trailing,
    this.detailsChildrenCount,
    this.key,
  })  : assert(detailsChildrenCount == null || detailsChildrenCount >= 0, 'detailsChildren must not be null and have a length bigger than zero'),
        super(
          selectable: true,
        );

  /// Key for the master widget
  final Key? key;

  /// The title widget that is shown in the list and as the title of the details
  /// page
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Additional content displayed below the title in the list, but also on the
  /// details page if showSubtitleOnDetails is set to true.
  ///
  /// Typically a [Text] widget.
  final Widget? subtitle;

  /// A widget to display before the title.
  ///
  /// Typically an [Icon] or a [CircleAvatar] widget.
  final Widget? leading;

  /// A widget to display after the title.
  ///
  /// Typically an [Icon] widget.
  final Widget? trailing;

  /// If set to true the subtitle is displayed below the title on the details
  /// page.
  final bool showSubtitleOnDetails;

  /// A function used to create children on demand in the details page. For more
  /// information you can also see [ListView.builder]
  ///
  /// The `detailsListChildBuilder` callback will be called only with indices greater than
  /// or equal to zero and less than `detailsChildrenCount`.
  ///
  /// The `detailsListChildBuilder` should always return a non-null widget, and actually
  /// create the widget instances when called. Avoid using a builder that
  /// returns a previously-constructed widget.
  final Widget Function(BuildContext context, int index)
      detailsListChildBuilder;

  /// Providing a non-null `detailsChildrenCount` improves the ability of the
  /// [ListView] inside of the details page to estimate the maximum scroll
  /// extent. If 'detailsChildrenCount' is set to 1 the children will be build
  /// outside of any ListView. See more [ListView.builder].
  final int? detailsChildrenCount;

  @override
  Widget buildWidget(BuildContext context,
      {bool selected = false, GestureTapCallback? onTap}) {
    assert(onTap != null, 'onTap must be specified for a MasterDetailFlowItem');
    return Ink(
      color: selected ? Theme.of(context).highlightColor : null,
      child: ListTile(
        key: key,
        title: title,
        subtitle: subtitle,
        onTap: onTap,
        leading: leading,
        trailing: trailing,
        selected: selected,
      ),
    );
  }
}

/// A master detail flow entry that can be used as title. 'child' can be
/// any type of Widget.
///
/// ```dart
///  masterItems: [
///     MasterDetailFlowTitle(
///       child: Container(
///         color: Colors.green,
///         height: 200,
///         child: const Center(
///           child: Text('Title'),
///         ),
///       ),
///     ),
///  ],
/// ```
///
/// See also:
///
///  * [MasterDetailFlowItem], a list tile that opens details.
///  * [MasterDetailFlowDivider], a master detail flow entry that is just a
///  simple divider.
class MasterDetailFlowTitle extends MasterDetailFlowItemBase {
  /// Creates the MasterDetailFlowTitle
  const MasterDetailFlowTitle({
    required this.child,
  }) : super(
          selectable: false,
        );

  /// The [child] contained by the MasterDetailFlowTitle.
  final Widget child;

  @override
  Widget buildWidget(BuildContext context,
      {bool selected = false, GestureTapCallback? onTap}) {
    return child;
  }
}

/// A master detail flow entry that is a simple divider for the other
/// MasterDetailFlow items.
///
/// See also:
///
///  * [MasterDetailFlowTitle], a master detail flow entry that is a title.
///  * [MasterDetailFlowItem], a list tile that open a details page.
class MasterDetailFlowDivider extends MasterDetailFlowItemBase {
  /// Creates a diver for MasterDetailFlow
  const MasterDetailFlowDivider({
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  }) : super(selectable: false);

  /// The divider widget. Usually a [Divider] or [Text]
  final Widget child;

  /// The amount of space by which to inset the child.
  final EdgeInsets? padding;

  @override
  Widget buildWidget(BuildContext context,
      {bool selected = false, GestureTapCallback? onTap}) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.labelMedium!,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
