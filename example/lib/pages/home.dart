import 'package:example/pages/customization.dart';
import 'package:example/pages/future.dart';
import 'package:example/pages/settings.dart';
import 'package:example/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:master_detail_flow/master_detail_flow.dart';

class HomePageFour extends StatelessWidget {
  const HomePageFour({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailsPageSliverList(
      title: const Text(
        'Learn more',
      ),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SizedBox(
              height: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Examples of what you can do:'),
                  FloatingActionButton.extended(
                    heroTag: 'settings',
                    onPressed: () {
                      // Do note that the page might be in another navigator
                      // And to push a page, you need to use the root navigator
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) => const PageSettings(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.settings),
                    label: const Text('A simple settings page'),
                  ),
                  FloatingActionButton.extended(
                    heroTag: 'future',
                    onPressed: () {
                      // Do note that the page might be in another navigator
                      // And to push a page, you need to use the root navigator
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) => const PageFuture(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.hourglass_empty_rounded),
                    label: const Text('Use a Future to load'),
                  ),
                  FloatingActionButton.extended(
                    heroTag: 'customization',
                    onPressed: () {
                      // Do note that the page might be in another navigator
                      // And to push a page, you need to use the root navigator
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) => const PageCustomization(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.wallpaper_rounded),
                    label: const Text('Use MDThemeData to customize'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HomePageThree extends StatelessWidget {
  const HomePageThree({super.key});

  @override
  Widget build(BuildContext context) {
    final isPage = DetailsPanelProvider.of(context).viewMode == MDViewMode.page;
    return DetailsPageSliverList(
      title: const Text(
        'Master item 3 - Empty page',
      ),
      appBarSize: MDAppBarSize.none,
      slivers: [
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LabelText('This is an empty page with no app bar'),
              const LabelText('You can add any widget here'),
              // Don't let the users pop the context if it's not a page, it will
              // pop the flow
              if (isPage)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Go back'),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class HomePageTwo extends StatelessWidget {
  const HomePageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailsPageSliverList(
      title: const Text(
        'Page two - DetailsPageSliverList',
      ),
      slivers: [
        SliverList.list(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Slivers are a powerful way to create custom scrollable areas.',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'This page has a SliverAppBar with a SliverList. Try to scroll!',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
        const SliverPadding(
          padding: EdgeInsets.symmetric(
            vertical: double.infinity,
          ),
        ),
      ],
    );
  }
}

/// This is the details item for the first master item
class HomePageOne extends StatelessWidget {
  const HomePageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailsPageScaffold(
      title: const Text(
        'Page one - DetailsPageScaffold',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LabelText(
                'Children can include everything you want like tiles'),
            for (int i = 1; i <= 5; i++)
              ListTile(
                title: Text('Tile $i'),
                subtitle: Text('Tile sub $i'),
                leading: Icon(
                  IconData(0xee34 + i, fontFamily: 'MaterialIcons'),
                ),
              ),
            const LabelText('Info about app?'),
            const ListTile(
              title: Text('Version'),
              subtitle: Text('1.0'),
            ),
          ],
        ),
      ),
    );
  }
}
