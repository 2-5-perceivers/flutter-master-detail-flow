import 'package:flutter/material.dart';
import 'package:master_detail_flow/src/enums/view_mode.dart';
import 'package:master_detail_flow/src/providers/controller.dart';

/// A padding that depends on the view mode.
///
/// See also:
///   * [MDController], a provider to access the view mode.
///   * [MDItem], a list tile that can be used in the master list to
/// open a details page.
class MDPadding extends StatelessWidget {
  /// Creates a padding that depends on the view mode, [panelPadding] defaults
  /// to a horizontal padding of 8, [pagePadding] defaults to a padding of 0.
  const MDPadding({
    required this.child,
    super.key,
    this.panelPadding,
    this.pagePadding,
  });

  /// The padding used when in a panel view.
  ///
  /// Defaults to `EdgeInsets.symmetric(horizontal: 8)`
  final EdgeInsetsGeometry? panelPadding;

  /// The padding used when in a page view.
  ///
  /// Defaults to [EdgeInsets.zero].
  final EdgeInsetsGeometry? pagePadding;

  /// The child contained by the padding.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final viewMode = MDController.viewModeOf(context);
    final padding = viewMode == MDViewMode.lateral
        ? (panelPadding ?? const EdgeInsets.symmetric(horizontal: 8))
        : (pagePadding ?? EdgeInsets.zero);

    return Padding(
      padding: padding,
      child: child,
    );
  }
}
