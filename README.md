# master_detail_flow
[![pub package](https://img.shields.io/pub/v/master_detail_flow?color=green)](https://pub.dartlang.org/packages/master_detail_flow)

A Flutter plugin that allows you to build fast, responsive and beautiful MasterDetailFlows using
Material 3 design that you can use to create your own license page or responsive layout page.

![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/s1.png?raw=true)

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
The MasterDetailsFlow will provide here a method to goBack if it is in page mode, a bool indicating if it is in page mode and app bar settings, but they can be ignored if wanted. Ensure that if you use app bars inside the details page you set `automaticallyImplyLeading: false` and create a way to go back if `settings.selfPage` is `true`. More details can be found in the example app under `example/lib/pages/custom_details_item.dart`.

## More
In the example app you can find examples of how to create:
* DetailsItem with a centered text
* Custom list
* Demo settings page
* MasterDetailsFlow inside a Future
* Custom DetailsItems
* Custom MasterItem

Also you should read https://pub.dev/documentation/master_detail_flow/latest/

![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/s2.png?raw=true) ![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/s3.png?raw=true) ![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/s4.png?raw=true) ![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/s5.png?raw=true) ![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/s6.png?raw=true)