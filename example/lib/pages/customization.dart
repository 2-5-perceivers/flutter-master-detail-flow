import 'package:example/widgets/master_label.dart';
import 'package:flutter/material.dart';
import 'package:master_detail_flow/master_detail_flow.dart';

class PageCustomization extends StatelessWidget {
  const PageCustomization({super.key});

  @override
  Widget build(BuildContext context) {
    return MDScaffold(
      items: [
        const DrawerHeader(
          child: Center(
            child: Text('An extremely customized MDScaffold'),
          ),
        ),
        MDItem(
          title: const Text('Item 1'),
          pageBuilder: (context) => const DetailsPageScaffold(
            title: Text('Item 1'),
          ),
        ),
        MDItem(
          title: const Text('Item 2'),
          pageBuilder: (context) => const DetailsPageScaffold(
            title: Text('Item 2'),
          ),
        ),
        const MasterLabel(data: 'Custom master item'),
        MDItem(
          title: const Text('Item 3'),
          pageBuilder: (context) => const DetailsPageScaffold(
            title: Text('Item 3'),
          ),
        ),
      ],
      title: const Text('Customization'),
      theme: MDThemeData(
        detailsPanelBackgroundColor:
            Theme.of(context).colorScheme.primaryContainer,
        detailsPanelBorderRadius: 50,
        masterPageAppBarSize: MDAppBarSize.medium,
        masterPanelWidth: 500,
        transitionAnimationDuration: const Duration(seconds: 2),
        noSelectedItemChildBuilder: (context) => const Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text('No item selected'),
            ),
          ),
        ),
      ),
      breakpoint: MDBreakpoint.large,
    );
  }
}
