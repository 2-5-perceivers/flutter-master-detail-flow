import 'package:example/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:master_detail_flow/master_detail_flow.dart';

class PageSettings extends StatelessWidget {
  const PageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return MDScaffold(
      title: const Text('Settings'),
      initialPageId: 'first',
      initialPageBuilder: settingsDetailsBuilder,
      items: [
        MDItem(
          title: const Text('Settings'),
          itemID: 'first',
          leading: const Icon(Icons.settings_rounded),
          pageBuilder: settingsDetailsBuilder,
        ),
        MDItem(
          title: const Text('About app'),
          leading: const Icon(Icons.flutter_dash_rounded),
          pageBuilder: (context) => const _PageSettingsAbout(),
        ),
      ],
    );
  }

  Widget settingsDetailsBuilder(context) => const _PageSettingsNotifications();
}

// About
class _PageSettingsAbout extends StatelessWidget {
  const _PageSettingsAbout();

  @override
  Widget build(BuildContext context) {
    return DetailsPageSliverList(
      title: const Text('About app'),
      slivers: [
        SliverList.list(
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
    return DetailsPageSliverList(
      title: const Text('Notifications'),
      slivers: [
        SliverList.list(
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
        ),
      ],
    );
  }
}
