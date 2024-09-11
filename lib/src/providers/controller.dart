import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:master_detail_flow/src/enums/focus.dart';
import 'package:master_detail_flow/src/enums/view_mode.dart';
import 'package:master_detail_flow/src/typedefs.dart';
import 'package:provider/provider.dart';

/// A provider that manages the flow. It stores the items, the view mode, the
/// focus, and the selected page.
///
/// To create custom flows, custom master widgets note these functions:
/// * [MDController.selectPage], to open a details page. This moves the focus to
/// details and sets the selected page.
/// * [MDController.items], to change the items in the master list or to get
/// them
/// * [MDController.focus], to change the focus or to get it
/// * [MDController.viewMode], to change the view mode or to get it. Use this to
/// keep the flow in sync with the constraints.
/// * [MDController.selectedPageId], to get the selected page id
/// * [MDController.selectedPageBuilder], to get the selected page builder
/// * [MDController.navigatorKey], to access the navigator in the nested layout
///
/// Used in [MDScaffold]
class MDController extends ChangeNotifier {
  /// Creates a [MDController].
  MDController({
    required List<Widget> items,
    required MDFocus focus,
    String? initialPageId,
    WidgetBuilder? initialPageBuilder,
  })  : _items = items,
        _focus = focus,
        _selectedPageId = initialPageId,
        _selectedPageBuilder = initialPageBuilder,
        assert(
          focus == MDFocus.master || initialPageId != null,
          'If focus is details, initialPageId must be provided',
        ),
        assert(
          initialPageId == null || initialPageBuilder != null,
          'If initialPageId is provided, initialPageBuilder must be provided',
        );

  /// Key to access navigator in the nested layout.
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Route name for the details page.
  static const String detailsRouteName = 'details';

  /// Route name for the master page.
  static const String masterRouteName = 'master';

  List<Widget> _items;

  /// The list of master widgets.
  List<Widget> get items => UnmodifiableListView(_items);
  set items(List<Widget> value) {
    _items = value;
    notifyListeners();
  }

  MDViewMode _viewMode = MDViewMode.lateral;

  /// Whether the flow is in lateral or page view mode.
  /// See also:
  /// * [MDViewMode], an enum that defines the view mode.
  MDViewMode get viewMode => _viewMode;
  set viewMode(MDViewMode value) {
    _viewMode = value;
    notifyListeners();
  }

  MDFocus _focus;
  String? _selectedPageId;
  MDWidgetBuilder? _selectedPageBuilder;

  /// The focus of the flow.
  /// See also:
  ///  * [MDFocus], an enum that defines the focus of the flow.
  MDFocus get focus => _focus;
  set focus(MDFocus value) {
    _focus = value;
    notifyListeners();
  }

  /// The ID of the selected page(master item). Use this to make the item
  /// selected.
  String? get selectedPageId {
    if (_viewMode == MDViewMode.page) {
      return null;
    }
    return _selectedPageId;
  }

  /// The builder for the selected page.
  MDWidgetBuilder? get selectedPageBuilder => _selectedPageBuilder;

  /// Selects a page(master item) and opens the details page.
  /// If [preventFocusChange] is set to true, the focus will not change.
  void selectPage(
    String id, {
    required MDWidgetBuilder builder,
    bool preventFocusChange = false,
  }) {
    _selectedPageId = id;
    _selectedPageBuilder = builder;
    if (!preventFocusChange) {
      _focus = MDFocus.details;
    }
    if (viewMode == MDViewMode.page && _focus == MDFocus.details) {
      unawaited(navigatorKey.currentState!.pushNamed(detailsRouteName));
    }

    notifyListeners();
  }

  /// Get the controller of the parent flow
  static MDController of(BuildContext context, {bool listen = true}) =>
      Provider.of<MDController>(context, listen: listen);

  /// Get the viewMode of the parent flow
  static MDViewMode viewModeOf(BuildContext context) => context
      .select<MDController, MDViewMode>((controller) => controller.viewMode);

  /// Get the selected page id of the parent flow
  static String? selectedPageIdOf(BuildContext context) => context
      .select<MDController, String?>((controller) => controller.selectedPageId);

  /// Get the items of the parent flow
  static List<Widget> itemsOf(BuildContext context) => context
      .select<MDController, List<Widget>>((controller) => controller.items);
}
