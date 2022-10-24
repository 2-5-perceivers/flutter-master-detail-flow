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
    this.initialPage,
    this.title,
    this.nothingSelectedWidget,
    this.lateralDetailsAppBar = DetailsAppBarSize.medium,
    this.pageDetailsAppBar = DetailsAppBarSize.large,
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

  /// The option title to be showed on the master app bar.
  final Widget? title;

  /// A widget to be showed in case there is no master selected. If not provided
  /// there will be used a simple text mentioning that no item is selected.
  final Widget? nothingSelectedWidget;

  /// The required list of items.
  final List<MasterItem> items;

  /// An optional integer to specify if the masterFlow should start with a
  /// selected page.
  final int? initialPage;

  /// Selects the app style used when details page is in lateral view.
  ///
  /// See:
  ///   * [DetailsAppBarSize]
  final DetailsAppBarSize lateralDetailsAppBar;

  /// Selects the app style used when details page is in page view.
  ///
  /// See:
  ///   * [DetailsAppBarSize]
  final DetailsAppBarSize pageDetailsAppBar;

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
      selectedItem = widget.items[widget.initialPage!];
      focus = Focus.details;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final double screenWidth = MediaQuery.of(context).size.width;
    final bool large = screenWidth >= 700;

    if (large) {
      return Scaffold(
        appBar: _appBar(),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              constraints: const BoxConstraints(
                maxWidth: 300,
              ),
              child: ListTileTheme(
                data: ListTileThemeData(
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
                    final MasterItem item = widget.items[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 2,
                      ),
                      child: ListTile(
                        title: Text(item.title),
                        leading: item.leading,
                        trailing: item.trailing,
                        selected: selectedItem?.title == item.title,
                        onTap: item.onTap ??
                            () {
                              setState(() {
                                selectedItem = item;
                                focus = Focus.details;
                              });
                            },
                      ),
                    );
                  },
                  itemCount: widget.items.length + 1,
                ),
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
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
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
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
                appBar: _appBar(),
                body: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    if (index == widget.items.length) {
                      return const FinalPadding();
                    }
                    final MasterItem item = widget.items[index];
                    return ListTile(
                      title: Text(item.title),
                      leading: item.leading,
                      trailing: item.trailing,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      onTap: item.onTap ??
                          () {
                            setState(() {
                              selectedItem = item;
                              focus = Focus.details;
                            });
                          },
                    );
                  },
                  itemCount: widget.items.length + 1,
                ),
              ),
      );
    }
  }

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: widget.autoImplyLeading,
      actions: widget.actions,
      title: widget.title,
      scrolledUnderElevation: 0,
    );
  }
}
