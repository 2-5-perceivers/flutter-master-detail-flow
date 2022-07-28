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
          colorSchemeSeed: Colors.blue),
      home: Scaffold(
        body: MasterDetailFlow.fromItems(
          title: const Text('MasterDetailFlow'),
          masterItems: <MasterDetailFlowItemBase>[
            MasterDetailFlowTitle(
              child: Container(
                color: Colors.green,
                height: 200,
                child: const Center(
                  child: Text('Title'),
                ),
              ),
            ),
            MasterDetailFlowItem(
              title: const Text('Option One'),
              detailsListChildBuilder: (BuildContext context, int index) =>
                  Text('Hello World $index'),
            ),
            const MasterDetailFlowDivider(child: Divider()),
            MasterDetailFlowItem(
              title: const Text('Option Two'),
              subtitle: const Text('This is the second option after a divider'),
              showSubtitleOnDetails: true,
              detailsListChildBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: double.maxFinite,
                child: Center(
                  child: Text('A centered object'),
                ),
              ),
              detailsChildrenCount: 1,
            ),
          ],
        ),
      ),
    );
  }
}
