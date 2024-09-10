import 'package:flutter/material.dart';
import 'package:master_detail_flow/master_detail_flow.dart';

class PageFuture extends StatelessWidget {
  const PageFuture({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 5), () => 'Done'),
      builder: (context, snapshot) {
        List<Widget> items;

        if (snapshot.connectionState != ConnectionState.done) {
          items = [
            const SizedBox(
              height: 100,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ];
        } else {
          items = [
            const ListTile(
              title: Text('Future is done'),
              subtitle: Text('The future has completed'),
            ),
          ];
        }
        return MDScaffold(
          title: const Text('Future'),
          items: items,
        );
      },
    );
  }
}
