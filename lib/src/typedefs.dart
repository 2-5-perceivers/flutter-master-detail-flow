import 'package:flutter/widgets.dart';

import 'package:master_detail_flow/src/details_items.dart';
import 'package:master_detail_flow/src/enums.dart';

/// Signature for the builder callback used by [MasterDetailFlow].
typedef MasterViewBuilder = Widget Function(
    BuildContext context, bool isLateralUI);

/// Signature for the builder callback used by [MasterDetailFlow.detailPageBuilder].
///
/// scrollController is provided when the page destination is the draggable
/// sheet in the lateral UI. Otherwise, it is null.
typedef DetailPageBuilder = Widget Function(BuildContext context,
    Object? arguments, ScrollController? scrollController);

/// Signature for the list of MasterDetailsFlowItemBase used by [MasterDetailFlow].
typedef MasterItemsList = List<MasterDetailFlowItemBase>;

/// Signature for the builder callback used by [MasterDetailFlow.actionBuilder].
///
/// Builds the actions that go in the app bars constructed for the master and
/// lateral UI pages. actionLevel indicates the intended destination of the
/// return actions.
typedef ActionBuilder = List<Widget> Function(
    BuildContext context, MasterDetailFlowActionLevel actionLevel);
