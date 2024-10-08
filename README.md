# master_detail_flow

<div align="center">

  [![GitHub stars][github_stars_badge]][github_stars_link]
  [![Package: master_detail_flow][package_badge]][package_link]
  [![Language: Dart][language_badge]][language_link]
  [![License: MIT][license_badge]][license_link]

</div>

[github_stars_badge]: https://img.shields.io/github/stars/2-5-perceivers/flutter-master-detail-flow?style=flat&color=yellow
[github_stars_link]: https://github.com/2-5-perceivers/flutter-master-detail-flow/stargazers
[package_badge]: https://img.shields.io/pub/v/master_detail_flow?color=green
[package_link]: https://pub.dev/packages/master_detail_flow
[language_badge]: https://img.shields.io/badge/language-Dart-blue
[language_link]: https://dart.dev
[license_badge]: https://img.shields.io/github/license/2-5-perceivers/flutter-master-detail-flow
[license_link]: https://opensource.org/licenses/MIT

**master_detail_flow** is a Flutter package designed to help you easily create sleek, responsive master-detail flows. Whether on mobile or larger screens, this package adapts to display a list of items with detailed views in a fast and user-friendly manner.

![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/demo.gif?raw=true)

## Installation

To use this package, add master_detail_flow as a dependency using:
```
flutter pub add master_detail_flow
```

## Getting started

The `MDScaffold` widget is your entry point to building master-detail flows with this package. It provides a simple and efficient way to set up a flow with just a few lines of code.


## Usage

Here’s a basic example of how to use `MDScaffold`:

```dart
MDScaffold(
  title: const Text('Simple flow'),
  items: [
    DrawerHeader(
      child: Center(
        child: Text('A flow'),
      ),
    ),
    MDItem(
      title: const Text('Master item 1'),
      pageBuilder: (_) => const HomePageOne(),
    ),
    MDItem(
      title: const Text('Master item 2'),
      pageBuilder: (_) => const HomePageTwo(),
    ),
    // This padding aligns the divider with the edges of the tiles
    const MDPadding(child: Divider()),
    MDItem(
      title: const Text('Master item 3'),
      pageBuilder: (_) => const HomePageThree(),
    ),
  ],
)
```

## Creating custom flow parts

The logic is divided among `MDScaffold`, `MDController`, `MDFlowView`, and `DetailsPanelProvider`. The default `MDScaffold` uses a `MDFlowView` wrapped in a `MDController` to manage the display of the master and detail panels.. For more information about every piece and how you can rewrite them read the documentation.

### Key components
* `MDScaffold`: Handles layout.
* `MDController`: Manages state.
* `MDFlowView`: Displays master-detail panels.
* `DetailsPanelProvider`: Supplies detail pages with information like background color and view mode.

## Using MDController & DetailsPanelProvider

To create a custom item for the master list that can react to information like the view mode, or to open pages, the widget needs to interact with the MDController. 

### Get the view mode
```dart 
MDController.viewModeOf(context);
```

### Open a page
```dart 
MDController.of(context, listen: false)
            .selectPage(
              'page id',
              builder: (context) => DetailsPageScaffold(),
            );
```

### Page id
The page id is stored in the controller, and can be used to show a widget as being selected.

```dart 
Widget(
  selected: controller.selectedPageId == ownId,
),
```

For more code examples explore the example app or the code for MDItem and MDPadding.

### Details pages
If `DetailsPageScaffold` and `DetailsPageSliverList` don't fit your needs, you can use `DetailsPanelProvider` to make sure your custom layout has access to the info it needs.

A custom details page needs to adapt to the ViewMode. In ViewMode.lateral AppBars should have `autoImplyLeading` and `primary` set to false so they don't pop the MDScaffold nor try to use safe area.

```dart
final panel = DetailsPanelProvider.of(context);
final isPageMode = panel.viewMode == MDViewMode.page;
final backgroudColor = backgroundColor ?? panel.backgroundColor;
```

## More
In the example app you can find examples of how to:
* Make a settings page
* Load a MDScaffold inside a Future
* Create a custom item for the master list
* Customize the MDScaffold
* Push routes from the details page

For further details, visit the [documentation](https://pub.dev/documentation/master_detail_flow/latest/).

![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/l1.png?raw=true) ![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/l2.png?raw=true) ![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/l3.png?raw=true)

![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/d1.png?raw=true) ![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/d2.png?raw=true) ![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/d3.png?raw=true)

![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/m1.png?raw=true) ![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/m2.png?raw=true)

![License page](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/license_page.png?raw=true)

## License

This project is licensed under the MIT License. See the [LICENSE](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/LICENSE) file for more details.