import 'package:example/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:master_detail_flow/master_detail_flow.dart';

class PageSettings extends StatelessWidget {
  const PageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasterDetailsFlow(
        // As an import page I suggest the large size
        masterAppBar: DetailsAppBarSize.large,
        nothingSelectedWidget: const Text(
          'Select a settings category from the left panel',
        ),
        title: const Text('Settings'),
        items: [
          MasterItem(
            'Notifications',
            leading: const Icon(Icons.settings_rounded),
            detailsBuilder: (context) => const _PageSettingsNotifications(),
          ),
          MasterItem(
            'About app',
            leading: const Icon(Icons.flutter_dash_rounded),
            detailsBuilder: (context) => const _PageSettingsAbout(),
          ),
        ],
      ),
    );
  }
}

// About
class _PageSettingsAbout extends StatelessWidget {
  const _PageSettingsAbout();

  @override
  Widget build(BuildContext context) {
    return DetailsItem(
      title: const Text('About app'),
      children: [
        const SizedBox(
          height: 300,
          child: Center(
            child: FlutterLogo(
              size: 200,
            ),
          ),
        ),
        // Example date. Use your own
        const ListTile(
          title: Text('Version'),
          subtitle: Text('2.1'),
        ),
        const ListTile(
          title: Text('Made by'),
          subtitle: Text('2.5 Perceivers'),
        ),
        ListTile(
          title: const Text('Terms and conditions'),
          trailing: Icon(Icons.adaptive.arrow_forward),
        ),
      ],
    );
  }
}

// Notifications
class _PageSettingsNotifications extends StatefulWidget {
  const _PageSettingsNotifications();

  @override
  State<_PageSettingsNotifications> createState() =>
      _PageSettingsNotificationsState();
}

class _PageSettingsNotificationsState
    extends State<_PageSettingsNotifications> {
  bool push = true, marketing = false, other = true;

  @override
  Widget build(BuildContext context) {
    return DetailsItem(
      title: const Text('Notifications'),
      children: [
        const LabelText('App notifications'),
        SwitchListTile(
          title: const Text('Push notifications'),
          value: push,
          onChanged: (value) {
            setState(() {
              push = !push;
            });
          },
        ),
        SwitchListTile(
          title: const Text('Marketing notifications'),
          value: marketing,
          onChanged: (value) {
            setState(() {
              marketing = !marketing;
            });
          },
        ),
        SwitchListTile(
          title: const Text('Other random notifications'),
          value: other,
          onChanged: (value) {
            setState(() {
              other = !other;
            });
          },
        ),
        const LabelText('Email notifications'),
        const SwitchListTile(
          title: Text('Annoying email notifications'),
          subtitle: Text('You want these?'),
          value: true,
          onChanged: null,
        ),
      ],
    );
  }
}
