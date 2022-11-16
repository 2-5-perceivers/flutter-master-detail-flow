import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart' hide Focus;
import 'package:master_detail_flow/src/enums.dart';
import 'package:master_detail_flow/src/flow_settings.dart';
import 'package:master_detail_flow/src/master_item.dart';
import 'package:master_detail_flow/src/padding_utils.dart';

/// A widgets that builds an adaptive M3 master <-> details flow. To start just
/// create a scaffold with it't only child being the [MasterDetailsFlow].
class MasterDetailsFlow extends StatefulWidget {
  /// Creates the flow
  const MasterDetailsFlow({
    required this.items,
    this.actions,
    this.autoImplyLeading = true,
    this.breakpoint = 700,
    this.initialPage,
    this.lateralMasterPanelWidth = 300.0,
    this.detailsPanelCornersRadius = 12.0,
    this.lateralListTileTheme,
    this.title,
    this.nothingSelectedWidget,
    this.lateralDetailsAppBar = DetailsAppBarSize.medium,
    this.pageDetailsAppBar = DetailsAppBarSize.large,
    this.masterAppBar = DetailsAppBarSize.small,
    this.transitionAnimationDuration = const Duration(milliseconds: 500),
    super.key,
  });

  /// A list of Widgets to display in a row after the [title] widget.
  ///
  /// Typically these widgets are [IconButton]s representing common operations.
  /// For less common operations, consider using a [PopupMenuButton] as the
  /// last action.
  final List<Widget>? actions;

  /// Controls whether we should try to imply the leading widget if null.
  ///
  /// If true and [leading] is null, automatically try to deduce what the leading
  /// widget should be. If false and [leading] is null, leading space is given to [title].
  /// If leading widget is not null, this parameter has no effect.
  final bool autoImplyLeading;

  /// If the screen width is larger than breakpoint it moves to lateral view,
  /// otherwise is in page mode.
  ///
  /// Defaults to 700.
  final int breakpoint;

  /// The width of the lateral panel that hold the tiles.
  ///
  /// Defaults to 300.0
  final double lateralMasterPanelWidth;

  /// The corners radius of the details panel
  ///
  /// Defaults to 12
  final double detailsPanelCornersRadius;

  /// The theme used by the selectable tiles on the lateral panel
  final ListTileThemeData? lateralListTileTheme;

  /// The option title to be showed on the master app bar.
  final Widget? title;

  /// A widget to be showed in case there is no master selected. If not provided
  /// there will be used a simple text mentioning that no item is selected.
  final Widget? nothingSelectedWidget;

  /// The required list of items.
  final List<MasterItemBase> items;

  /// An optional integer to specify if the masterFlow should start with a
  /// selected page.
  final int? initialPage;

  /// Selects the app bar style used when details page is in lateral view.
  ///
  /// See:
  ///   * [DetailsAppBarSize]
  final DetailsAppBarSize lateralDetailsAppBar;

  /// Selects the app bar style used when details page is in page view.
  ///
  /// See:
  ///   * [DetailsAppBarSize]
  final DetailsAppBarSize pageDetailsAppBar;

  /// Selects the app bar style used when the master list is in page view.
  ///
  /// See:
  ///   * [DetailsAppBarSize]
  final DetailsAppBarSize masterAppBar;

  /// The default transition animation duration
  final Duration transitionAnimationDuration;

  @override
  State<MasterDetailsFlow> createState() => _MasterDetailsFlowState();
}

class _MasterDetailsFlowState extends State<MasterDetailsFlow> {
  Focus focus = Focus.master;
  MasterItem? selectedItem;

  @override
  void initState() {
    super.initState();
    if (widget.initialPage != null) {
      assert(
        widget.initialPage! < widget.items.length,
        'Initial page out of bounds',
      );
      selectedItem = widget.items[widget.initialPage!] as MasterItem;
      if (window.physicalSize.width >= widget.breakpoint) {
        focus = Focus.details;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final double screenWidth = MediaQuery.of(context).size.width;
    final bool large = screenWidth >= widget.breakpoint;

    if (large) {
      return Scaffold(
        appBar: _appBar(),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                maxWidth: widget.lateralMasterPanelWidth,
              ),
              child: ListTileTheme(
                data: widget.lateralListTileTheme ??
                    ListTileThemeData(
                      selectedColor: colorScheme.onSecondaryContainer,
                      selectedTileColor: colorScheme.secondaryContainer,
                      iconColor: colorScheme.onSurfaceVariant,
                      textColor: colorScheme.onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      contentPadding: const EdgeInsetsDirectional.only(
                        start: 16,
                        end: 24,
                      ),
                    ),
                style: ListTileStyle.drawer,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    if (index == widget.items.length) {
                      return const FinalPadding();
                    }
                    final MasterItemBase itemBase = widget.items[index];
                    if (itemBase is Widget) {
                      return itemBase as Widget;
                    }
                    final MasterItem item = itemBase as MasterItem;
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            theme.listTileTheme.contentPadding?.horizontal ??
                                16,
                        vertical: 2,
                      ),
                      child: listTileBuilder(item),
                    );
                  },
                  itemCount: widget.items.length + 1,
                ),
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: widget.transitionAnimationDuration,
                transitionBuilder:
                    (Widget child, Animation<double> animation) =>
                        const FadeUpwardsPageTransitionsBuilder()
                            .buildTransitions<void>(
                  null,
                  null,
                  animation,
                  null,
                  child,
                ),
                child: Padding(
                  key: ValueKey<MasterItem?>(selectedItem),
                  padding: const EdgeInsetsDirectional.only(
                    end: 12,
                  ),
                  child: Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(widget.detailsPanelCornersRadius),
                      ),
                    ),
                    color: ElevationOverlay.applySurfaceTint(
                      colorScheme.surface,
                      colorScheme.surfaceTint,
                      selectedItem == null ? 0 : 1,
                    ),
                    elevation: selectedItem == null ? 0 : 10,
                    clipBehavior: Clip.antiAlias,
                    child: MasterDetailsFlowSettings(
                      appBarSize: widget.lateralDetailsAppBar,
                      selfPage: false,
                      child: selectedItem?.detailsBuilder?.call(context) ??
                          Center(
                            child: widget.nothingSelectedWidget ??
                                const Text('Select a tile from the left panel'),
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return PageTransitionSwitcher(
        duration: const Duration(milliseconds: 500),
        reverse: focus == Focus.master,
        transitionBuilder: (
          Widget child,
          Animation<double> primaryAnimation,
          Animation<double> secondaryAnimation,
        ) {
          return const ZoomPageTransitionsBuilder().buildTransitions<Object>(
            null,
            null,
            primaryAnimation,
            secondaryAnimation,
            child,
          );
        },
        child: focus == Focus.details && selectedItem != null
            ? MasterDetailsFlowSettings(
                key: ValueKey<Focus>(focus),
                appBarSize: widget.pageDetailsAppBar,
                selfPage: true,
                goBack: () {
                  if (mounted) {
                    setState(() {
                      focus = Focus.master;
                    });
                  }
                },
                child: Scaffold(
                  body: selectedItem!.detailsBuilder!(context),
                ),
              )
            : Scaffold(
                key: ValueKey<MasterItem?>(selectedItem),
                body: CustomScrollView(
                  slivers: <Widget>[
                    _sliverAppBar(widget.masterAppBar),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final MasterItemBase itemBase = widget.items[index];
                          if (itemBase is Widget) {
                            return itemBase as Widget;
                          }
                          final MasterItem item = itemBase as MasterItem;
                          return listTileBuilder(item, page: true);
                        },
                        childCount: widget.items.length,
                      ),
                    ),
                    const SliverFinalPadding(),
                  ],
                ),
              ),
      );
    }
  }

  ListTile listTileBuilder(
    MasterItem item, {
    bool page = false,
  }) {
    final Widget? subtitle =
        item.subtitle != null ? Text(item.subtitle!) : null;

    return ListTile(
      title: Text(item.title),
      subtitle: subtitle,
      leading: item.leading,
      trailing: item.trailing,
      selected: (selectedItem?.title == item.title) && !page,
      onTap: item.onTap ??
          () {
            setState(() {
              selectedItem = item;
              focus = Focus.details;
            });
          },
    );
  }

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: widget.autoImplyLeading,
      actions: widget.actions,
      title: widget.title,
      scrolledUnderElevation: 0,
    );
  }

  SliverAppBar _sliverAppBar(DetailsAppBarSize appBarSize) {
    switch (appBarSize) {
      case DetailsAppBarSize.small:
        return SliverAppBar(
          actions: widget.actions,
          title: widget.title,
        );
      case DetailsAppBarSize.medium:
        return SliverAppBar.medium(
          actions: widget.actions,
          title: widget.title,
        );
      case DetailsAppBarSize.large:
        return SliverAppBar.large(
          actions: widget.actions,
          title: widget.title,
        );
    }
  }
}
