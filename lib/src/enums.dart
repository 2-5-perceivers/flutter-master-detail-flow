/// Describes which type of app bar the actions are intended for.
enum MasterDetailFlowActionLevel {
  /// Indicates the top app bar in the lateral UI.
  top,

  /// Indicates the master view app bar in the lateral UI.
  view,
}

/// Describes the actual focus
enum Focus {
  ///Focus on the master
  master,

  /// Focus on details
  detail,
}

/// Describes which layout will be used by [MasterDetailFlow].
enum MasterDetailFlowLayoutMode {
  /// Use a nested or lateral layout depending on available screen width.
  auto,

  /// Always use a lateral layout.
  lateral,

  /// Always use a nested layout.
  nested,
}
