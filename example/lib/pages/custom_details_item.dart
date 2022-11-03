import 'package:flutter/material.dart';
import 'package:master_detail_flow/master_detail_flow.dart';

/// To create your custom DetailsItem all you need is to get the flow's settings
/// by using `MasterDetailsFlowSettings.of(context)` then you just need to
/// override all the ways to go back, including the app bar ones, so disable
/// implyLeading on all app bars
class CustomDetailsItem extends StatelessWidget {
  const CustomDetailsItem({super.key});

  @override
  Widget build(BuildContext context) {
    MasterDetailsFlowSettings? settings = MasterDetailsFlowSettings.of(context);
    bool selfPage = settings?.selfPage ?? false;
    return WillPopScope(
      // WillPopScope overrides the system back button so we move back the flow
      onWillPop: () async {
        if (settings?.selfPage == true) {
          settings!.goBack!();
        }
        return !(settings?.selfPage ?? false);
      },
      child: SizedBox.expand(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(selfPage ? 'This is a page' : 'This is a panel'),
              FilledButton.tonalIcon(
                onPressed: settings?.goBack,
                icon: Icon(Icons.adaptive.arrow_back_rounded),
                label: const Text('Go back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageCustom extends StatelessWidget {
  const PageCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasterDetailsFlow(
        title: const Text('Custom DetailsItem'),
        items: [
          MasterItem(
            'Custom',
            detailsBuilder: (context) => const CustomDetailsItem(),
          ),
        ],
      ),
    );
  }
}
