# master_detail_flow
[![pub package](https://img.shields.io/pub/v/master_detail_flow?color=green)](https://pub.dartlang.org/packages/master_detail_flow)

A Flutter plugin that allows you to build fast, responsive and beautiful MasterDetailFlows using
Material 3 design that you can use to create your own license page or responsive layout page.

![Screeshot](https://github.com/2-5-perceivers/flutter_master_details_flow/raw/main/images/s1.png)

## Getting started

The package exposes a `MasterDetailsFlow` widget. You can use the widget inside a Scaffold.

## Usage

Create a new MasterDetailsFlow  and provide the MasterItems list. Read more in documentation.

```dart
Scaffold(
  body: MasterDetailsFlow(
    title: const Text(_title),
    items: [
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
    ],
  ),
),
```

## Create a custom details page
Start by creating a new widget and then, inside the widget get the Flow Settings using
```dart 
final MasterDetailsFlowSettings? settings =
        MasterDetailsFlowSettings.of(context);
```
The MasterDetailsFlow will provide here a method to goBack if it is in page mode, a bool indicating if it is in page mode and app bar settings, but they can be ignored if wanted. Ensure that if you use app bars inside the details page you set `automaticallyImplyLeading: false` and create a way to go back if `settings.selfPage` is `true`.
