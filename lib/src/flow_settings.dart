import 'package:flutter/widgets.dart';
import 'package:master_detail_flow/src/enums.dart';

/// The settings provider for a details page
class MasterDetailsFlowSettings extends InheritedWidget {
  /// Creates a Flow Settings to be used by a details item. If selfPage is true
  /// goBack must be specified.
  const MasterDetailsFlowSettings({
    required super.child,
    required this.appBarSize,
    this.selfPage = false,
    this.goBack,
    super.key,
  }) : assert(
          selfPage == (goBack != null),
          'goBack must be specified only when selfPage is true',
        );

  /// If details is a page by itself. Is false if the details should be showed
  /// in lateral view.
  final bool selfPage;

  /// The function that would move the focus back to master in a selfPage scenario.
  final void Function()? goBack;

  /// The selected app bar type
  final DetailsAppBarSize appBarSize;

  /// Obtains the settings to be used by a details item or one of it's ancestors.
  static MasterDetailsFlowSettings? of(BuildContext context) {
    final MasterDetailsFlowSettings? result =
        context.dependOnInheritedWidgetOfExactType<MasterDetailsFlowSettings>();
    return result;
  }

  @override
  bool updateShouldNotify(MasterDetailsFlowSettings oldWidget) {
    return selfPage != oldWidget.selfPage;
  }
}
