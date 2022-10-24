import 'package:flutter/material.dart';
import 'package:master_detail_flow/master_detail_flow.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
      ),
      home: Scaffold(
        body: MasterDetailsFlow(
          title: const Text(_title),
          items: [
            const MasterItemHeader(
              child: Text('jndjdn'),
            ),
            MasterItem(
              'Item one',
              detailsBuilder: (_) => const DetailsItem(
                title: Text(
                  'Item one details title',
                ),
              ),
            ),
            MasterItem(
              'Item two',
              detailsBuilder: (_) => const DetailsItem(
                title: Text(
                  'Item two details title',
                ),
                children: [
                  Text('One children'),
                ],
              ),
            ),
            MasterItem(
              'Advanced item 3',
              detailsBuilder: (_) => DetailsItem(
                title: const Text(
                  'Using a custom sliver',
                ),
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Text('This is item $index'),
                    ),
                  ),
                ],
              ),
            ),
            const MasterItemDivider(),
            MasterItem(
              'Item 4',
              leading: const Icon(Icons.account_tree_rounded),
              detailsBuilder: (_) => DetailsItem(
                title: const Text(
                  'Using a custom sliver',
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.help,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
