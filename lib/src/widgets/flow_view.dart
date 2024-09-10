import 'package:flutter/material.dart';
import 'package:master_detail_flow/src/enums/focus.dart';
import 'package:master_detail_flow/src/enums/view_mode.dart';
import 'package:master_detail_flow/src/models/theme.dart';
import 'package:master_detail_flow/src/providers/controller.dart';
import 'package:master_detail_flow/src/providers/details.dart';
import 'package:master_detail_flow/src/providers/theme.dart';
import 'package:provider/provider.dart';

/// A flow view that displays the master and details panels in lateral or page
/// It is used by the scaffold widgets to build the flow.
///
/// See also:
///   * [MDScaffold], a scaffold that displays a master-detail flow in material
/// design.
class MDFlowView extends StatelessWidget {
  /// Creates a [MDFlowView].
  const MDFlowView({
    required this.mdTheme,
    required this.sliverAppBar,
    required this.isLateralView,
    super.key,
  });

  /// The theme of the flow view and its children.
  final MDThemeData? mdTheme;

  /// The sliver app bar to display in the master page.
  final Widget sliverAppBar;

  /// Wether the flow view is in lateral or page view mode
  final bool isLateralView;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MDController>();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final mdTheme = (MDTheme.mayOf(context) ?? MDThemeData()).copyWith(
      detailsPanelBorderRadius: this.mdTheme?.detailsPanelBorderRadius,
      masterPageAppBarSize: this.mdTheme?.masterPageAppBarSize,
      masterPanelListTileTheme: this.mdTheme?.masterPanelListTileTheme,
      masterPanelWidth: this.mdTheme?.masterPanelWidth,
      noSelectedItemChildBuilder: this.mdTheme?.noSelectedItemChildBuilder,
      transitionAnimationDuration: this.mdTheme?.transitionAnimationDuration,
      detailsPanelBackgroundColor: this.mdTheme?.detailsPanelBackgroundColor,
    );

    final masterPanelListTileTheme =
        _masterPanelListTileThemeBuilder(mdTheme, colorScheme);
    final masterPageListTileTheme = mdTheme.masterPageListTileTheme;

    final masterPanelWidth = mdTheme.masterPanelWidth ?? 300;
    final transitionDuration = mdTheme.transitionAnimationDuration ??
        const Duration(milliseconds: 500);
    final detailsPanelBorderRadius = mdTheme.detailsPanelBorderRadius ?? 12;
    final detailsPanelBackgroundColor =
        mdTheme.detailsPanelBackgroundColor ?? colorScheme.surfaceContainer;

    if (isLateralView) {
      return _lateralView(
        masterPanelListTileTheme,
        masterPanelWidth,
        controller,
        context,
        mdTheme,
        transitionDuration,
        detailsPanelBorderRadius,
        detailsPanelBackgroundColor,
      );
    } else {
      final masterPageRoute =
          _masterPageRoute(context, masterPageListTileTheme, controller.items);
      return _pageView(controller, masterPageRoute);
    }
  }

  MaterialPageRoute<void> _detailPageRoute(MDController controller) =>
      MaterialPageRoute<void>(
        builder: (context) => PopScope<void>(
          onPopInvokedWithResult: (didPop, result) {
            controller.focus = MDFocus.master;
          },
          child: Provider(
            create: (_) => DetailsPanelProvider(
              viewMode: MDViewMode.page,
              backgroundColor: null,
            ),
            child: BlockSemantics(
              child: controller.selectedPageBuilder!(context),
            ),
          ),
        ),
      );

  Widget _detailsPanelBuilder(
    BuildContext context,
    MDController controller,
    MDThemeData mdTheme,
    Duration transitionDuration,
    double detailsPanelBorderRadius,
    Color detailsPanelBackgroundColor,
  ) =>
      Expanded(
        // Use a notification listener to prevent scroll notifications from
        // reaching outside the panel.
        // Mostly to prevent the app bar from reacting to scroll events in the
        // panel
        child: NotificationListener<Notification>(
          onNotification: (notification) =>
              notification is ScrollMetricsNotification ||
              notification is ScrollNotification,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              end: 12,
            ),
            child: Provider.value(
              value: DetailsPanelProvider(
                viewMode: MDViewMode.lateral,
                backgroundColor: detailsPanelBackgroundColor,
              ),
              updateShouldNotify: (previous, current) =>
                  previous.backgroundColor != current.backgroundColor,
              child: AnimatedSwitcher(
                duration: transitionDuration,
                transitionBuilder: (child, animation) =>
                    const FadeUpwardsPageTransitionsBuilder().buildTransitions(
                  null,
                  context,
                  animation,
                  null,
                  child,
                ),
                child: _DetailsPanelCard(
                  key: ValueKey(controller.selectedPageId),
                  isASelectedPage: controller.selectedPageId != null,
                  radius: detailsPanelBorderRadius,
                  backgroundColor: detailsPanelBackgroundColor,
                  builder: (context) {
                    // Use [Builder] widgets to insert the right context in the
                    // builder methods
                    if (controller.selectedPageBuilder != null) {
                      return Builder(builder: controller.selectedPageBuilder!);
                    } else if (mdTheme.noSelectedItemChildBuilder != null) {
                      return Builder(
                        builder: mdTheme.noSelectedItemChildBuilder!,
                      );
                    }

                    return const Center(
                      child: Text('Select a tile from the left panel'),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );

  Row _lateralView(
    ListTileThemeData masterPanelListTileTheme,
    double masterPanelWidth,
    MDController controller,
    BuildContext context,
    MDThemeData mdTheme,
    Duration transitionDuration,
    double detailsPanelBorderRadius,
    Color detailsPanelBackgroundColor,
  ) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          _masterPanelBuilder(
            masterPanelListTileTheme,
            masterPanelWidth,
            controller.items,
          ),
          _detailsPanelBuilder(
            context,
            controller,
            mdTheme,
            transitionDuration,
            detailsPanelBorderRadius,
            detailsPanelBackgroundColor,
          ),
        ],
      );

  MaterialPageRoute<void> _masterPageRoute(
    BuildContext context,
    ListTileThemeData? masterPageListTileTheme,
    List<Widget> items,
  ) =>
      MaterialPageRoute<dynamic>(
        builder: (context) => _MasterPage(
          sliverAppBar: sliverAppBar,
          listTileTheme: masterPageListTileTheme,
        ),
      );

  Widget _masterPanelBuilder(
    ListTileThemeData masterPanelListTileTheme,
    double masterPanelWidth,
    List<Widget> items,
  ) =>
      ListTileTheme(
        data: masterPanelListTileTheme,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: masterPanelWidth),
          child: ListView.builder(
            itemBuilder: (context, index) => items[index],
            itemCount: items.length,
          ),
        ),
      );

  ListTileThemeData _masterPanelListTileThemeBuilder(
    MDThemeData mdTheme,
    ColorScheme colorScheme,
  ) =>
      ListTileThemeData(
        selectedColor: mdTheme.masterPanelListTileTheme?.selectedColor ??
            colorScheme.onSecondaryContainer,
        selectedTileColor:
            mdTheme.masterPanelListTileTheme?.selectedTileColor ??
                colorScheme.secondaryContainer,
        iconColor: mdTheme.masterPanelListTileTheme?.iconColor ??
            colorScheme.onSurfaceVariant,
        textColor: mdTheme.masterPanelListTileTheme?.textColor ??
            colorScheme.onSurface,
        shape: mdTheme.masterPanelListTileTheme?.shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
        contentPadding: mdTheme.masterPanelListTileTheme?.contentPadding ??
            const EdgeInsetsDirectional.only(
              start: 16,
              end: 24,
            ),
        style: mdTheme.masterPanelListTileTheme?.style ?? ListTileStyle.drawer,
        dense: mdTheme.masterPanelListTileTheme?.dense,
        horizontalTitleGap:
            mdTheme.masterPanelListTileTheme?.horizontalTitleGap,
        enableFeedback: mdTheme.masterPanelListTileTheme?.enableFeedback,
        leadingAndTrailingTextStyle:
            mdTheme.masterPanelListTileTheme?.leadingAndTrailingTextStyle,
        minLeadingWidth: mdTheme.masterPanelListTileTheme?.minLeadingWidth,
        minTileHeight: mdTheme.masterPanelListTileTheme?.minTileHeight,
        minVerticalPadding:
            mdTheme.masterPanelListTileTheme?.minVerticalPadding,
        mouseCursor: mdTheme.masterPanelListTileTheme?.mouseCursor,
        subtitleTextStyle: mdTheme.masterPanelListTileTheme?.subtitleTextStyle,
        tileColor: mdTheme.masterPanelListTileTheme?.tileColor,
        visualDensity: mdTheme.masterPanelListTileTheme?.visualDensity,
        titleAlignment: mdTheme.masterPanelListTileTheme?.titleAlignment,
        titleTextStyle: mdTheme.masterPanelListTileTheme?.titleTextStyle,
      );

  NavigatorPopHandler _pageView(
    MDController controller,
    MaterialPageRoute<void> masterPageRoute,
  ) =>
      NavigatorPopHandler(
        onPop: () async {
          await controller.navigatorKey.currentState!.maybePop();
        },
        child: Navigator(
          key: controller.navigatorKey,
          initialRoute: 'initial',
          onGenerateInitialRoutes: (navigator, initialRoute) =>
              switch (controller.focus) {
            MDFocus.master => <Route<void>>[masterPageRoute],
            MDFocus.details => <Route<void>>[
                masterPageRoute,
                _detailPageRoute(controller),
              ],
          },
          onGenerateRoute: (settings) {
            if (settings.name == MDController.masterRouteName) {
              controller.focus = MDFocus.master;
              return masterPageRoute;
            } else if (settings.name == MDController.detailsRouteName) {
              controller.focus = MDFocus.details;
              return _detailPageRoute(controller);
            }
            return null;
          },
        ),
      );
}

class _DetailsPanelCard extends StatelessWidget {
  const _DetailsPanelCard({
    required this.isASelectedPage,
    required this.radius,
    required this.builder,
    required this.backgroundColor,
    super.key,
  });

  final bool isASelectedPage;
  final double radius;
  final Color backgroundColor;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => RepaintBoundary(
        child: Material(
          elevation: isASelectedPage ? 10 : 0,
          color: isASelectedPage ? backgroundColor : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(radius),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: builder(context),
        ),
      );
}

/// The master page that displays a sliver app bar and a list of items.
class _MasterPage extends StatelessWidget {
  const _MasterPage({
    required this.sliverAppBar,
    required this.listTileTheme,
  });

  final Widget sliverAppBar;
  final ListTileThemeData? listTileTheme;

  @override
  Widget build(BuildContext context) {
    final items = MDController.itemsOf(context);
    return RepaintBoundary(
      child: BlockSemantics(
        child: ListTileTheme(
          data: listTileTheme,
          child: CustomScrollView(
            slivers: [
              sliverAppBar,
              SliverList.builder(
                itemBuilder: (context, index) => items[index],
                itemCount: items.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
