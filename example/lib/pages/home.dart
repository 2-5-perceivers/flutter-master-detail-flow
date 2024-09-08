/* import 'package:example/pages/custom_details_item.dart';
import 'package:example/pages/future.dart';
import 'package:example/pages/settings.dart';
import 'package:example/widgets/label.dart'; */
import 'package:flutter/material.dart';
import 'package:master_detail_flow/master_detail_flow.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MDScaffold(
        title: const Text('Simple flow'),
        items: [
          DrawerHeader(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'MasterDetailsFlow',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ),
          MDItemPage(
            title: const Text('Master item 1'),
            subtitle: const Text('Tap to learn more about children'),
            pageBuilder: (_) => const Placeholder(),
          ),
          MDItemPage(
            title: const Text('Master item 2'),
            subtitle: const Text('Tap to learn about slivers'),
            pageBuilder: (_) => const Placeholder(),
          ),
          MDItemPage(
            title: const Text('Master item 3'),
            pageBuilder: (_) => const Placeholder(),
          ),
          Divider(),
          MDItemPage(
            title: const Text('Master item 4'),
            subtitle: const Text('Master items can have icons'),
            leading: const Icon(Icons.unfold_more_double_outlined),
            pageBuilder: (_) => const Placeholder(),
          ),
        ],
      ),
    );
  }
}
/* 
class _HomePageFour extends StatelessWidget {
  const _HomePageFour();

  @override
  Widget build(BuildContext context) {
    return DetailsItem(
      title: const Text(
        'Learn more',
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: SizedBox(
            height: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('See this examples'),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PageSettings(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.settings),
                  label: const Text('A simple settings page'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PageFuture(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.hourglass_empty_rounded),
                  label: const Text('Use a Future to load'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PageCustom(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert_outlined),
                  label: const Text('Custom DetailsItem'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HomePageThree extends StatelessWidget {
  const _HomePageThree();

  @override
  Widget build(BuildContext context) {
    return DetailsItem(
      title: const Text(
        'Using a custom list',
      ),
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
              title: Text('This is item $index'),
            ),
          ),
        ),
      ],
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'DetailsItem places all the items inside a CustomScrollView.\nAll the children are put in a SliverListView inside the CustomScrollView, but if you want to use a custom list/grid you can by using a SliverList/SliverGrid inside the slivers field.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        const LabelText('This example builds and infite amount of children')
      ],
    );
  }
}

class _HomePageTwo extends StatelessWidget {
  const _HomePageTwo();

  @override
  Widget build(BuildContext context) {
    return DetailsItem(
      title: const Text(
        'Page two - slivers',
      ),
      slivers: [
        SliverFillRemaining(
          fillOverscroll: false,
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'What?',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Text(
                    'Using slivers we can create effects(See master item 3) or fill the remaining space to center widgets like this one.',
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

/// This is the details item for the first master item
class _HomePageOne extends StatelessWidget {
  const _HomePageOne();

  @override
  Widget build(BuildContext context) {
    return DetailsItem(
      title: const Text(
        'Page one - children',
      ),
      children: [
        const LabelText('Children can include everything you want like tiles'),
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
    );
  }
}
 */