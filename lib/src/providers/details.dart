import 'package:flutter/material.dart';
import 'package:master_detail_flow/src/enums/view_mode.dart';
import 'package:provider/provider.dart';

/// A provider that wraps details pages and panels to provide the view mode and
/// the background color if in panel view mode.
class DetailsPanelProvider {
  /// Creates a [DetailsPanelProvider].
  DetailsPanelProvider({required this.viewMode, required this.backgroundColor});

  /// The view mode of the current details page/panel.
  final MDViewMode viewMode;

  /// The background color of the panel. Only used in panel view mode.
  /// Otherwise, it is null.
  final Color? backgroundColor;

  /// Returns the nearest [DetailsPanelProvider]. It does not listen to changes.
  static DetailsPanelProvider of(BuildContext context) =>
      context.watch<DetailsPanelProvider>();
}
