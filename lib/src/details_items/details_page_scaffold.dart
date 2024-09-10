import 'package:flutter/material.dart';
import 'package:master_detail_flow/src/enums/view_mode.dart';
import 'package:master_detail_flow/src/providers/details.dart';

/// A scaffold for the details page.
///
/// This widget provides a scaffold for displaying the details page.
/// It is typically used as the root widget for the details page.
/// The scaffold includes a [AppBar] at the top and a [Body] below it.
/// The [AppBar] displays the title of the details page.
/// The [Body] contains the main content of the details page.
///
/// The [DetailsPageScaffold] also ensures that the [AppBar] has the right
/// configuration depending on the current view mode.
///
/// Example:
/// ```dart
/// DetailsPageScaffold(
///   title: Text('Details'),
///   body: Placeholder(),
/// )
/// ```
///
/// See also:
///   * [DetailsPageSliverList], a similar widget that uses a [CustomScrollView]
/// and [SliverAppBar]
///   * [DetailsPanelProvider], a class that provides information for custom
/// details pages
class DetailsPageScaffold extends StatelessWidget {
  /// Creates a scaffold for the details page.
  const DetailsPageScaffold({
    super.key,
    this.title,
    this.appBarLeading,
    this.appBarActions,
    this.appBarCenterTitle,
    this.appBarForegroundColor,
    this.body,
    this.backgroundColor,
  });

  /// The title of the details page.
  final Widget? title;

  /// The leading widget for the [AppBar]. If provided, in page view mode, the
  /// leading widget will be displayed instead of the back button.
  final Widget? appBarLeading;

  /// The actions for the [AppBar].
  final List<Widget>? appBarActions;

  /// Whether the title of the [AppBar] should be centered.
  final bool? appBarCenterTitle;

  /// The foreground color of the [AppBar].
  final Color? appBarForegroundColor;

  /// The main content of the details page.
  final Widget? body;

  /// The background color of the scaffold. Only used in lateral view mode.
  /// If not provided, the background color from the parent [MDFlowView] will be
  /// used.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final panel = DetailsPanelProvider.of(context);
    final isPageMode = panel.viewMode == MDViewMode.page;
    final backgroudColor = backgroundColor ?? panel.backgroundColor;

    return Scaffold(
      backgroundColor: backgroudColor,
      primary: !isPageMode,
      appBar: AppBar(
        title: title,
        leading: appBarLeading,
        actions: appBarActions,
        automaticallyImplyLeading: isPageMode,
        centerTitle: appBarCenterTitle,
        backgroundColor: backgroudColor,
        primary: isPageMode,
        foregroundColor: appBarForegroundColor,
      ),
      body: body,
    );
  }
}
