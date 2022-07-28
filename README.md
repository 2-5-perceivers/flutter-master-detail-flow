# master_detail_flow
[![pub package](https://img.shields.io/pub/v/master_detail_flow?color=green)](https://pub.dartlang.org/packages/master_detail_flow)

A Flutter plugin that allows you to build fast, responsive and beautiful MasterDetailFlows using
Material 3 design that you can use to create your own license page or responsive layout page.

## Getting started

The package exposes a `MasterDetailFlow` widget. You can use the widget as a page itself or inside a
Scaffold.

## Usage

Create a new MasterDetailFlow using its fromItems constructor. You can also use the normal
constructor for more advanced usages.

```dart
MasterDetailFlow.fromItems(
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
```
