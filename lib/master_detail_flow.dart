/// Master Detail Flow is a Flutter package that provides a simple way to create
/// a master-detail flow layout.
library master_detail_flow;

export 'src/details_items/details_page_scaffold.dart' show DetailsPageScaffold;
export 'src/details_items/details_page_sliver_list.dart'
    show DetailsPageSliverList;
export 'src/enums/app_bar_size.dart' show MDAppBarSize;
export 'src/enums/breakpoint.dart' show MDBreakpoint;
export 'src/enums/focus.dart' show MDFocus;
export 'src/enums/view_mode.dart' show MDViewMode;
export 'src/items/padding.dart' show MDPadding;
export 'src/items/page.dart' show MDItem;
export 'src/models/theme.dart' show MDThemeData;
export 'src/providers/controller.dart' show MDController;
export 'src/providers/details.dart' show DetailsPanelProvider;
export 'src/providers/theme.dart' show MDTheme;
export 'src/widgets/flow_view.dart' show MDFlowView;
export 'src/widgets/material_licenses_page.dart'
    show MDLicensesPage, MDLicensesPageHeader;
export 'src/widgets/material_scaffold.dart' show MDScaffold;
