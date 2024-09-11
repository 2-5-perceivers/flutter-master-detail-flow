import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:master_detail_flow/master_detail_flow.dart';

/// A replacement for the [LicensePage] widget that uses the master detail flow,
/// allowing for a more customizations.
class MDLicensesPage extends StatefulWidget {
  /// Creates a customizable licenses page.
  const MDLicensesPage({
    this.appBarAutoImplyLeading = true,
    this.breakpoint = MDBreakpoint.medium,
    this.initialFocus = MDFocus.master,
    super.key,
    this.licensePackageCompare,
    this.appBarLeading,
    this.appBarActions,
    this.title,
    this.items,
    this.initialPageId,
    this.initialPageBuilder,
    this.theme,
  });

  /// A function to compare two package names. This is used to sort the packages
  /// in the master list. If not provided, the packages will be sorted
  /// alphabetically, puttting the application package first.
  final int Function(String a, String b)? licensePackageCompare;

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

  /// The title to be showed on the master detail flow.
  ///
  /// Defaults to [MaterialLocalizations.licensesPageTitle].
  final Widget? title;

  /// If the screen width is larger than the breakpoint it moves to lateral
  /// view, otherwise is in page mode.
  ///
  /// Defaults to [MDBreakpoint.medium].
  final int breakpoint;

  /// The widgets to be displayed in the master list before the licenses.
  final List<Widget>? items;

  /// An optional ID to specify if the masterFlow should start with a
  /// selected page. The initial page will only be shown in page mode if the
  /// initial focus is set to [MDFocus.details].
  /// If set it also needs an [initialPageBuilder]. Use this if you want to
  /// start with a specific license page.
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
  State<MDLicensesPage> createState() => _MDLicensesPageState();
}

class _MDLicensesPageState extends State<MDLicensesPage> {
  late final Future<_LicenseData> licenses = LicenseRegistry.licenses
      .fold<_LicenseData>(
        _LicenseData(),
        (prev, license) => prev..addLicense(license),
      )
      .then(
        (licenseData) =>
            licenseData..sortPackages(widget.licensePackageCompare),
      );

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);

    return FutureBuilder(
      future: licenses,
      builder: (context, snapshot) {
        final licenseItems = <Widget>[];
        MDItem? firstLicenseItem;

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final licensesData = snapshot.data!;

          for (final package in licensesData.packages) {
            final bindings = licensesData.packageLicenseBindings[package];
            licenseItems.add(
              MDItem(
                title: Text(package),
                subtitle: Text(
                  localizations.licensesPackageDetailText(
                    bindings?.length ?? 0,
                  ),
                ),
                pageBuilder: (context) {
                  Widget body;

                  if (bindings == null) {
                    body = const Center(child: Text('No packages'));
                  } else {
                    body = _LicenseDetailsPage(
                      packageName: package,
                      licenseBindings: bindings,
                      licenses: licensesData.licenses,
                    );
                  }

                  return DetailsPageScaffold(
                    title: Text(package),
                    body: body,
                  );
                },
              ),
            );
          }
          firstLicenseItem = licenseItems.firstOrNull as MDItem?;
        } else {
          licenseItems.add(
            const SizedBox(
              height: 300,
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          );
        }

        final scaffold = MDScaffold(
          appBarActions: widget.appBarActions,
          appBarAutoImplyLeading: widget.appBarAutoImplyLeading,
          appBarLeading: widget.appBarLeading,
          title: widget.title ?? Text(localizations.licensesPageTitle),
          breakpoint: widget.breakpoint,
          initialFocus: widget.initialFocus,
          theme: MDThemeData(
            noSelectedItemChildBuilder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          initialPageBuilder:
              widget.initialPageBuilder ?? firstLicenseItem?.pageBuilder,
          initialPageId: widget.initialPageId ?? firstLicenseItem?.itemId,
          items: [
            ...?widget.items,
            ...licenseItems,
          ],
        );

        final child = widget.theme != null
            ? MDTheme(
                data: widget.theme!,
                child: scaffold,
              )
            : scaffold;

        return child;
      },
    );
  }
}

/// A simple header that displays app information. Best used in the licenses
/// page.
class MDLicensesPageHeader extends StatelessWidget {
  /// Creates a header for the licenses page.
  const MDLicensesPageHeader({
    super.key,
    this.appIcon,
    this.appName,
    this.appLegalese,
  });

  /// The app icon to display in the header.
  final Widget? appIcon;

  /// The app name to display in the header.
  final Widget? appName;

  /// The app legalese to display in the header. Typically copyrights, but
  /// can be any app information like the version.
  final String? appLegalese;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 200),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (appIcon != null)
              IconTheme(
                data: theme.iconTheme.copyWith(size: 48),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: appIcon,
                ),
              ),
            if (appName != null)
              DefaultTextStyle(
                style: textTheme.headlineMedium!.copyWith(
                  color: colorScheme.primary,
                ),
                child: appName!,
              ),
            if (appLegalese != null)
              Text(
                appLegalese!,
                style: textTheme.labelLarge,
              ),

            // Add a way to show the license count.
            /* Text(
              MaterialLocalizations.of(context)
                  .licensesPackageDetailText(licensesCount),
              style: textTheme.labelLarge,
            ), */
          ],
        ),
      ),
    );
  }
}

/// This is a collection of licenses and the packages to which they apply.
/// [packageLicenseBindings] records the m+:n+ relationship between the license
/// and packages as a map of package names to license indexes.
class _LicenseData {
  final List<LicenseEntry> licenses = <LicenseEntry>[];
  final Map<String, List<int>> packageLicenseBindings = <String, List<int>>{};
  final List<String> packages = <String>[];

  // Special treatment for the first package since it should be the package
  // for delivered application.
  String? firstPackage;

  void addLicense(LicenseEntry entry) {
    // Before the license can be added, we must first record the packages to
    // which it belongs.
    for (final package in entry.packages) {
      _addPackage(package);
      // Bind this license to the package using the next index value. This
      // creates a contract that this license must be inserted at this same
      // index value.
      packageLicenseBindings[package]!.add(licenses.length);
    }
    licenses.add(entry); // Completion of the contract above.
  }

  /// Add a package and initialize package license binding. This is a no-op if
  /// the package has been seen before.
  void _addPackage(String package) {
    if (!packageLicenseBindings.containsKey(package)) {
      packageLicenseBindings[package] = <int>[];
      firstPackage ??= package;
      packages.add(package);
    }
  }

  /// Sort the packages using some comparison method, or by the default manner,
  /// which is to put the application package first, followed by every other
  /// package in case-insensitive alphabetical order.
  void sortPackages([
    int Function(String a, String b)? compare,
  ]) {
    packages.sort(
      compare ??
          (String a, String b) => a.toLowerCase().compareTo(b.toLowerCase()),
    );
  }
}

class _LicenseDetailsPage extends StatefulWidget {
  const _LicenseDetailsPage({
    required this.packageName,
    required this.licenseBindings,
    required this.licenses,
  });

  final String packageName;
  final List<int> licenseBindings;
  final List<LicenseEntry> licenses;
  @override
  _LicenseDetailsPageState createState() => _LicenseDetailsPageState();
}

class _LicenseDetailsPageState extends State<_LicenseDetailsPage> {
  @override
  void initState() {
    super.initState();
    _initLicenses();
  }

  late final List<LicenseEntry> _licenseEntries;
  final List<Widget> _licenses = <Widget>[];
  bool _loaded = false;

  // An init method does not need to return a future.
  // ignore: avoid_void_async
  void _initLicenses() async {
    _licenseEntries = widget.licenseBindings
        .map((i) => widget.licenses[i])
        .toList(growable: false);

    for (final license in _licenseEntries) {
      if (!mounted) {
        return;
      }

      final paragraphs =
          await SchedulerBinding.instance.scheduleTask<List<LicenseParagraph>>(
        () => license.paragraphs.toList(growable: false),
        Priority.animation,
        debugLabel: 'License',
      );

      if (!mounted) {
        return;
      }

      setState(
        () {
          _licenses.add(
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12,
              ),
              child: Divider(),
            ),
          );

          for (final paragraph in paragraphs) {
            if (paragraph.indent == LicenseParagraph.centeredIndent) {
              _licenses.add(
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    paragraph.text,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else {
              assert(paragraph.indent >= 0);
              _licenses.add(
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: 8,
                    start: 16.0 * paragraph.indent,
                  ),
                  child: Text(paragraph.text),
                ),
              );
            }
          }
        },
      );
    }

    setState(() {
      _loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const pad = 20.0;

    final listWidgets = <Widget>[
      ..._licenses,
      if (!_loaded)
        const SizedBox(
          height: 300,
          child: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
    ];

    return DefaultTextStyle(
      style: theme.textTheme.bodySmall!,
      child: Localizations.override(
        locale: const Locale('en'),
        context: context,
        child: Padding(
          padding: const EdgeInsets.only(
            left: pad,
            right: pad,
            bottom: pad,
          ),
          child: ListView.builder(
            itemBuilder: (context, index) => listWidgets[index],
            itemCount: listWidgets.length,
            shrinkWrap: true,
            primary: false,
            addAutomaticKeepAlives: true,
          ),
        ),
      ),
    );
  }
}
