import 'package:example/pages/home.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.purple,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.purple,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MDScaffold(
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
        MDItem(
          title: const Text('Master item 1'),
          subtitle: const Text('Tap to learn about DetailsPageScaffold'),
          pageBuilder: (_) => const HomePageOne(),
        ),
        MDItem(
          title: const Text('Master item 2'),
          subtitle: const Text('Tap to learn about DetailsPageSliverList'),
          pageBuilder: (_) => const HomePageTwo(),
        ),
        MDItem(
          title: const Text('Master item 3'),
          pageBuilder: (_) => const HomePageThree(),
        ),
        const MDPadding(child: Divider()),
        MDItem(
          title: const Text('Master item 4'),
          subtitle: const Text('Master items can have icons'),
          leading: const Icon(Icons.unfold_more_double_outlined),
          pageBuilder: (_) => const HomePageFour(),
        ),
        const MDPadding(child: AboutListTile()),
      ],
    );
  }
}
