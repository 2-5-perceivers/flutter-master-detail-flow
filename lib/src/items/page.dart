import 'package:flutter/material.dart';
import 'package:master_detail_flow/src/enums/view_mode.dart';
import 'package:master_detail_flow/src/providers/controller.dart';
import 'package:master_detail_flow/src/typedefs.dart';
import 'package:provider/provider.dart';

/// A ListTile that opens a details page when tapped. For simpler customization,
/// provide list tile themes in a [MDTheme] widget or in [MDScaffold].
///
/// This widget has default padding that depends on the view mode like
/// [MDPadding]. Customize using the [pagePadding] and [panelPadding]
/// properties.
///
/// Example:
/// ```dart
/// MDItem(
///   title: Text('Item 1'),
///   pageBuilder: (context) => DetailsPageScaffold(
///     title: 'Item 1',
///     body: Placeholder(),
///   ),
/// )
/// ```
///
/// See also:
///   * [MDController], a provider that manages the flow, and can be used to
/// create custom master widgets.
///  * [MDPadding], a padding that depends on the view mode.
class MDItem extends StatelessWidget {
  /// Creates a [MDItem].
  MDItem({
    required this.title,
    required this.pageBuilder,
    String? itemID,
    super.key,
    this.leading,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.dense,
    this.visualDensity,
    this.shape,
    this.style,
    this.selectedColor,
    this.iconColor,
    this.textColor,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.leadingAndTrailingTextStyle,
    this.contentPadding,
    this.enabled = true,
    this.onLongPress,
    this.onFocusChange,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.focusNode,
    this.autofocus = false,
    this.tileColor,
    this.selectedTileColor,
    this.enableFeedback,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.minLeadingWidth,
    this.minTileHeight,
    this.titleAlignment,
    this.panelPadding,
    this.pagePadding,
  }) : itemId = itemID ?? title.hashCode.toString();

  /// The ID of the item. If not provided, the title's hash code is used.
  final String itemId;

  /// The builder for the details page.
  final MDWidgetBuilder pageBuilder;

  /// The title of the item.
  final Widget title;

  /// The padding used when in a panel view.
  ///
  /// Defaults to `EdgeInsets.symmetric(horizontal: 8, vertical: 2)`
  final EdgeInsetsGeometry? panelPadding;

  /// The padding used when in a page view.
  ///
  /// Defaults to [EdgeInsets.zero].
  final EdgeInsetsGeometry? pagePadding;

  /// The leading widget of the item.
  final Widget? leading;

  /// The subtitle of the item.
  final Widget? subtitle;

  /// The trailing widget of the item.
  final Widget? trailing;

  /// Whether the item is three lines.
  final bool isThreeLine;

  /// Whether the item should be dense.
  final bool? dense;

  /// The visual density of the item.
  final VisualDensity? visualDensity;

  /// The shape of the item.
  final ShapeBorder? shape;

  /// The color of the icons in the item.
  final Color? iconColor;

  /// The style of the tile. See [ListTileStyle].
  final ListTileStyle? style;

  /// The color of the item text and icons if selected.
  final Color? selectedColor;

  /// The color of the text in the item.
  final Color? textColor;

  /// The title text style of the item.
  final TextStyle? titleTextStyle;

  /// The subtitle text style of the item.
  final TextStyle? subtitleTextStyle;

  /// The leading and trailing text style of the item.
  final TextStyle? leadingAndTrailingTextStyle;

  /// The content padding of the item.
  final EdgeInsets? contentPadding;

  /// Whether the item is enabled.
  final bool enabled;

  /// The callback for when the item is long pressed.
  final VoidCallback? onLongPress;

  /// The callback for when the focus changes.
  final ValueChanged<bool>? onFocusChange;

  /// The mouse cursor configuration of the item. See [MouseCursor].
  final MouseCursor? mouseCursor;

  /// The item color when focused.
  final Color? focusColor;

  /// The item color when hovered.
  final Color? hoverColor;

  /// The splash color of the item.
  final Color? splashColor;

  /// The focus node of the item.
  final FocusNode? focusNode;

  /// Whether the item is autofocused.
  final bool autofocus;

  /// The color of the item.
  final Color? tileColor;

  /// The color of the item when selected.
  final Color? selectedTileColor;

  /// Whether to enable feedback.
  final bool? enableFeedback;

  /// The gap between the title and the leading/trailing widgets.
  final double? horizontalTitleGap;

  /// The minimum vertical padding of the item.
  final double? minVerticalPadding;

  /// The minimum leading width of the item.
  final double? minLeadingWidth;

  /// The minimum tile height of the item.
  final double? minTileHeight;

  /// The alignment of the title. See [ListTileTitleAlignment].
  final ListTileTitleAlignment? titleAlignment;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MDController>();
    final padding = controller.viewMode == MDViewMode.lateral
        ? (panelPadding ??
            const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ))
        : (pagePadding ?? EdgeInsets.zero);
    return Padding(
      padding: padding,
      child: ListTile(
        title: title,
        onTap: () {
          controller.selectPage(itemId, builder: pageBuilder);
        },
        selected: controller.selectedPageId == itemId,
        autofocus: autofocus,
        contentPadding: contentPadding,
        dense: dense,
        enabled: enabled,
        focusColor: focusColor,
        focusNode: focusNode,
        hoverColor: hoverColor,
        iconColor: iconColor,
        isThreeLine: isThreeLine,
        leading: leading,
        minLeadingWidth: minLeadingWidth,
        minTileHeight: minTileHeight,
        minVerticalPadding: minVerticalPadding,
        mouseCursor: mouseCursor,
        onLongPress: onLongPress,
        selectedTileColor: selectedTileColor,
        shape: shape,
        splashColor: splashColor,
        subtitle: subtitle,
        subtitleTextStyle: subtitleTextStyle,
        tileColor: tileColor,
        titleAlignment: titleAlignment,
        titleTextStyle: titleTextStyle,
        trailing: trailing,
        visualDensity: visualDensity,
        enableFeedback: enableFeedback,
        horizontalTitleGap: horizontalTitleGap,
        leadingAndTrailingTextStyle: leadingAndTrailingTextStyle,
        style: style,
        textColor: textColor,
        onFocusChange: onFocusChange,
        selectedColor: selectedColor,
      ),
    );
  }
}
