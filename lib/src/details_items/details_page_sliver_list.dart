import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:master_detail_flow/src/enums/app_bar_size.dart';
import 'package:master_detail_flow/src/enums/view_mode.dart';
import 'package:master_detail_flow/src/providers/details.dart';

/// A scaffold for the details page that uses a [CustomScrollView] and
/// [SliverAppBar].
///
/// This widget provides a scaffold for displaying the details page.
/// It is typically used as the root widget for the details page.
/// The scaffold includes a [SliverAppBar] at the top in a [CustomScrollView].
///
/// The [DetailsPageScaffold] also ensures that the [SliverAppBar] has the right
/// configuration depending on the current view mode and [MDAppBarSize].
///
/// Example:
/// ```dart
/// DetailsPageSliverList(
///   title: Text('Details'),
///   slivers: [
///     SliverList(),
///   ],
/// )
/// ```
///
/// See also:
///   * [DetailsPageScaffold], a similar widget that uses a [Scaffold] and
/// [AppBar]
///   * [DetailsPanelProvider], a class that provides information for custom
/// details pages
class DetailsPageSliverList extends StatelessWidget {
  /// Creates a [DetailsPageSliverList].
  const DetailsPageSliverList({
    required this.slivers,
    super.key,
    this.title,
    this.backgroundColor,
    this.appBarLeading,
    this.appBarActions,
    this.appBarCenterTitle,
    this.appBarForegroundColor,
    this.appBarSize = MDAppBarSize.large,
    this.scrollViewAnchor = 0.0,
    this.scrollViewCacheExtent,
    this.scrollViewController,
    this.scrollViewDragStartBehavior = DragStartBehavior.start,
    this.scrollViewKeyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    this.scrollViewKey,
    this.scrollViewScrollBehavior,
    this.scrollViewPsysics,
    this.scrollViewPrimary,
    this.scrollViewHitTestBehavior = HitTestBehavior.opaque,
    this.scrollViewRestorationId,
    this.scrollViewReverse = false,
    this.scrollViewScrollDirection = Axis.vertical,
    this.scrollViewSemanticChildCount,
    this.scrollViewShrinkWrap = false,
  });

  /// The size of the [AppBar]. Defaults to [MDAppBarSize.large]. To remove the
  /// [AppBar], set this to [MDAppBarSize.none].
  ///
  /// See also:
  ///   * [MDAppBarSize], an enum that defines the presence or size of the
  /// [AppBar]
  final MDAppBarSize appBarSize;

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

  /// The slivers to be displayed in the [CustomScrollView]. The widgets must be
  /// sliver widgets. Consider using a [SliverList] or [SliverGrid].
  final List<Widget> slivers;

  /// The background color of the scaffold. Only used in lateral view mode.
  /// If not provided, the background color from the parent [MDFlowView] will be
  /// used.
  final Color? backgroundColor;

  /// The anchor position to be used in the [CustomScrollView].
  /// Defaults to 0.0.
  final double scrollViewAnchor;

  /// The cache extent to be used in the [CustomScrollView].
  final double? scrollViewCacheExtent;

  /// The controller to be used in the [CustomScrollView].
  final ScrollController? scrollViewController;

  /// The drag start behavior to be used in the [CustomScrollView].
  /// Defaults to [DragStartBehavior.start].
  final DragStartBehavior scrollViewDragStartBehavior;

  /// The keyboard dismiss behavior to be used in the [CustomScrollView].
  /// Defaults to [ScrollViewKeyboardDismissBehavior.manual].
  final ScrollViewKeyboardDismissBehavior scrollViewKeyboardDismissBehavior;

  /// The key to be used in the [CustomScrollView].
  final Key? scrollViewKey;

  /// The scroll behavior to be used in the [CustomScrollView].
  final ScrollBehavior? scrollViewScrollBehavior;

  /// The physics to be used in the [CustomScrollView].
  final ScrollPhysics? scrollViewPsysics;

  /// The primary to be used in the [CustomScrollView].
  final bool? scrollViewPrimary;

  /// The hit test behavior to be used in the [CustomScrollView].
  /// Defaults to [HitTestBehavior.opaque].
  final HitTestBehavior scrollViewHitTestBehavior;

  /// The restoration id to be used in the [CustomScrollView].
  final String? scrollViewRestorationId;

  /// The reverse to be used in the [CustomScrollView].
  /// Defaults to false.
  final bool scrollViewReverse;

  /// The scroll direction to be used in the [CustomScrollView].
  /// Defaults to [Axis.vertical].
  final Axis scrollViewScrollDirection;

  /// The semantic child count to be used in the [CustomScrollView].
  final int? scrollViewSemanticChildCount;

  /// The shrink wrap to be used in the [CustomScrollView].
  /// Defaults to false.
  final bool scrollViewShrinkWrap;

  @override
  Widget build(BuildContext context) {
    final panel = DetailsPanelProvider.of(context);
    final isPageMode = panel.viewMode == MDViewMode.page;
    final backgroudColor = backgroundColor ?? panel.backgroundColor;

    final sliverAppBar = _sliverAppBar(isPageMode, backgroudColor);

    return Scaffold(
      backgroundColor: backgroudColor,
      body: CustomScrollView(
        anchor: scrollViewAnchor,
        cacheExtent: scrollViewCacheExtent,
        controller: scrollViewController,
        dragStartBehavior: scrollViewDragStartBehavior,
        keyboardDismissBehavior: scrollViewKeyboardDismissBehavior,
        key: scrollViewKey,
        physics: scrollViewPsysics,
        primary: scrollViewPrimary,
        hitTestBehavior: scrollViewHitTestBehavior,
        restorationId: scrollViewRestorationId,
        reverse: scrollViewReverse,
        scrollDirection: scrollViewScrollDirection,
        semanticChildCount: scrollViewSemanticChildCount,
        shrinkWrap: scrollViewShrinkWrap,
        scrollBehavior: scrollViewScrollBehavior,
        slivers: <Widget>[
          if (sliverAppBar != null) sliverAppBar,
          ...slivers,
        ],
      ),
    );
  }

  Widget? _sliverAppBar(bool isPageMode, Color? backgroundColor) =>
      switch (appBarSize) {
        MDAppBarSize.none => null,
        MDAppBarSize.small => SliverAppBar(
            title: title,
            leading: appBarLeading,
            actions: appBarActions,
            automaticallyImplyLeading: isPageMode,
            centerTitle: appBarCenterTitle,
            backgroundColor: backgroundColor,
            primary: isPageMode,
            foregroundColor: appBarForegroundColor,
          ),
        MDAppBarSize.medium => SliverAppBar.medium(
            title: title,
            leading: appBarLeading,
            actions: appBarActions,
            automaticallyImplyLeading: isPageMode,
            centerTitle: appBarCenterTitle,
            backgroundColor: backgroundColor,
            primary: isPageMode,
            foregroundColor: appBarForegroundColor,
          ),
        MDAppBarSize.large => SliverAppBar.large(
            title: title,
            leading: appBarLeading,
            actions: appBarActions,
            automaticallyImplyLeading: isPageMode,
            centerTitle: appBarCenterTitle,
            backgroundColor: backgroundColor,
            primary: isPageMode,
            foregroundColor: appBarForegroundColor,
          ),
      };
}
