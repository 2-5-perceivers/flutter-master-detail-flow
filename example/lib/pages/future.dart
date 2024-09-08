/* import 'package:flutter/material.dart';
import 'package:master_detail_flow/master_detail_flow.dart';

class PageFuture extends StatelessWidget {
  const PageFuture({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MasterItem>>(
        future: Future.delayed(
            const Duration(seconds: 5),
            () => [
                  MasterItem(
                    'From future 1',
                    leading: const Icon(Icons.settings_rounded),
                    detailsBuilder: (context) =>
                        const DetailsItem(title: Text('')),
                  ),
                  MasterItem(
                    'From future 2',
                    leading: const Icon(Icons.flutter_dash_rounded),
                    detailsBuilder: (context) =>
                        const DetailsItem(title: Text('')),
                  ),
                ]),
        builder: (context, snapshot) {
          return Scaffold(
            body: MasterDetailsFlow(
              title: const Text('Future'),
              nothingSelectedWidget:
                  snapshot.connectionState == ConnectionState.done
                      ? null
                      : Container(), // Used to hide the selection text
              items: snapshot.connectionState == ConnectionState.done
                  ? snapshot.data!
                  : [
                      const _MasterLoading(),
                    ],
            ),
          );
        });
  }
}

/// Custom MasterItem
class _MasterLoading extends StatelessWidget implements MasterItemBase {
  const _MasterLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 200,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
 */