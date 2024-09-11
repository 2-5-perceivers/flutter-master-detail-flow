import 'package:flutter/material.dart';
import 'package:master_detail_flow/src/enums/app_bar_size.dart';
import 'package:master_detail_flow/src/enums/breakpoint.dart';
import 'package:master_detail_flow/src/enums/focus.dart';
import 'package:master_detail_flow/src/enums/view_mode.dart';
import 'package:master_detail_flow/src/models/theme.dart';
import 'package:master_detail_flow/src/providers/controller.dart';
import 'package:master_detail_flow/src/providers/theme.dart';
import 'package:master_detail_flow/src/widgets/flow_view.dart';
import 'package:provider/provider.dart';

/// An adaptive M3 master <-> details flow scaffold. The flow
/// can be displayed in two modes: lateral and page. Lateral  mode is displayed
/// when the screen width is larger than the breakpoint, otherwise the flow is
/// displayed in page mode.
///
/// See the examples for more information on how to use this widget.
///
/// See also:
///   * [MDItem], A master item that opens a details page.
///   * [DetailsPageScaffold], a scaffold that can be used in the details page.
///   * [MDTheme], a widget that provides the theme for the master detail flow.
class MDScaffold extends StatefulWidget {
  /// Creates the flow
  const MDScaffold({
    required this.items,
    this.appBarLeading,
    this.appBarActions,
    this.appBarAutoImplyLeading = true,
    this.breakpoint = MDBreakpoint.medium,
    this.initialPageId,
    this.initialPageBuilder,
    this.initialFocus = MDFocus.master,
    this.title,
    super.key,
    this.theme,
  });

  /// A widget to display before the [title].
  ///
  /// Typically the [appBarLeading] widget is an [Icon] or an [IconButton].
  final Widget? appBarLeading;

  /// A list of Widgets to display in a row after the [title]
  ///
  /// Typically these widgets are [IconButton]s representing common operations.
  /// For less common operations, consider using a [PopupMenuButton] as the
  /// last action.
  final List<Widget>? appBarActions;

  /// Controls whether the app bar should try to imply the leading widget if
  /// [appBarLeading] is null.
  ///
  /// If true and [appBarLeading] is null, automatically try to deduce what the
  /// leading widget should be. If false and [appBarLeading] is null, leading
  /// space is given to [title]. If leading widget is not null, this parameter
  /// has no effect.
  ///
  /// Defaults to true.
  final bool appBarAutoImplyLeading;

  /// The optional title to be showed on the master detail flow.
  final Widget? title;

  /// If the screen width is larger than the breakpoint it moves to lateral
  /// view, otherwise is in page mode.
  ///
  /// Defaults to [MDBreakpoint.medium].
  final int breakpoint;

  /// The widgets to be displayed in the master list.
  final List<Widget> items;

  /// An optional ID to specify if the masterFlow should start with a
  /// selected page. The initial page will only be shown in page mode if the
  /// initial focus is set to [MDFocus.details].
  /// If set it also needs an [initialPageBuilder].
  ///
  /// See:
  ///   * [initialFocus]
  ///   * [MDFocus]
  final String? initialPageId;

  /// An optional builder to specify the initial page to be shown.
  final WidgetBuilder? initialPageBuilder;

  /// Sets the initial focus on either the master or details page.
  /// If the initial focus is set to [MDFocus.details] and an [initialPageId] is
  /// set, the flow will push the inital page to full screen in page mode.
  ///
  /// Defaults to [MDFocus.master].
  ///
  /// See:
  ///   * [MDFocus]
  final MDFocus initialFocus;

  /// The theme of the master detail flow. Unset values will fallback to the
  /// values from the inherited [MDTheme] or the default values.
  final MDThemeData? theme;

  @override
  State<MDScaffold> createState() => _MDScaffoldState();
}

class _MDScaffoldState extends State<MDScaffold> {
  late MDController _controller;

  @override
  Widget build(BuildContext context) {
    _controller.items = widget.items;
    return LayoutBuilder(
      builder: (context, constraints) {
        final lateralView = constraints.maxWidth > widget.breakpoint;

        _controller.viewMode =
            lateralView ? MDViewMode.lateral : MDViewMode.page;

        final controlledFlow = ChangeNotifierProvider.value(
          value: _controller,
          child: _flowBuilder(context, lateralView: lateralView),
        );

        if (lateralView) {
          return _lateralFlow(controlledFlow);
        } else {
          return _pageFlow(controlledFlow);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = MDController(
      items: widget.items,
      focus: widget.initialFocus,
      initialPageId: widget.initialPageId,
      initialPageBuilder: widget.initialPageBuilder,
    );
  }

  @override
  void didUpdateWidget(covariant MDScaffold oldWidget) {
    if (oldWidget.items != widget.items) {
      _controller.items = widget.items;
    }
    super.didUpdateWidget(oldWidget);
  }

  AppBar _appBar() => AppBar(
        automaticallyImplyLeading: widget.appBarAutoImplyLeading,
        leading: widget.appBarLeading,
        actions: widget.appBarActions,
        title: widget.title,
      );

  MDFlowView _flowBuilder(BuildContext context, {required bool lateralView}) =>
      MDFlowView(
        sliverAppBar: _sliverAppBar(context),
        mdTheme: widget.theme,
        isLateralView: lateralView,
      );

  Widget _lateralFlow(Widget flowWidget) => Scaffold(
        appBar: _appBar(),
        body: flowWidget,
      );

  Widget _pageFlow(Widget flowWidget) => Scaffold(body: flowWidget);

  Widget _sliverAppBar(BuildContext context) {
    final inheritedTheme = MDTheme.mayOf(context);
    final appBarSize = widget.theme?.masterPageAppBarSize ??
        inheritedTheme?.masterPageAppBarSize ??
        MDAppBarSize.large;

    // Since this app bar will be inside a separate navigator, we need to
    // handle the leading button ourselves. And pop the navigation from
    // the context of the scaffold.
    var leading = widget.appBarLeading;
    if (leading == null && widget.appBarAutoImplyLeading) {
      if (ModalRoute.of(context)?.impliesAppBarDismissal ?? false) {
        leading = BackButton(
          onPressed: () async {
            await Navigator.maybePop(context);
          },
        );
      }
    }
    switch (appBarSize) {
      case MDAppBarSize.small:
        return SliverAppBar(
          leading: leading,
          actions: widget.appBarActions,
          title: widget.title,
          automaticallyImplyLeading: widget.appBarAutoImplyLeading,
        );
      case MDAppBarSize.medium:
        return SliverAppBar.medium(
          leading: leading,
          actions: widget.appBarActions,
          title: widget.title,
          automaticallyImplyLeading: widget.appBarAutoImplyLeading,
        );
      case MDAppBarSize.large:
        return SliverAppBar.large(
          leading: leading,
          actions: widget.appBarActions,
          title: widget.title,
          automaticallyImplyLeading: widget.appBarAutoImplyLeading,
        );
      case MDAppBarSize.none:
        return const SliverToBoxAdapter();
    }
  }
}
