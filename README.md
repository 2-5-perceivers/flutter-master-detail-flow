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

A Flutter plugin that allows you to build fast, responsive and beautiful master <-> details flows.

![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/s1.png?raw=true)

## Getting started

The package exposes a `MDScaffold` widget. This is the simplest and usually the best way to implement a Flow.


## Usage

Create a new MDScaffold and provide the items list with any widgets you want, use MDItem to show details. Read more in documentation.

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
The logic of the flow has been splitted among widgets and the MDController. The default MDScaffold builts a scaffold that inside uses a MDFlowView wrapped in a MDController context. The MDFlowView is responsabile for displaying the two panels and wrapping the Details panel or page in a DetailsPanelProvider. The DetailsPanelProvider is used by the details pages to know if they are shown as standalone pages or panels, and if shown as panels, the captured backgroundColor for the panel. For more information about every piece and how you can rewrite them read the documentation.

[`MDScaffold` + `MDController`] -> [`MDFlowView` + `DetailsPanelProvider`] -> `DetailsPageScaffold/DetailsPanelSliverList/Custom`

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

The page id is stored in the controller, and can be used to show a widget as being selected.

```dart 
Widget(
  selected: controller.selectedPageId == ownId,
),
```

For more code examples explore the example app or the code for MDItem and MDPadding.

If DetailsPageScaffold and DetailsPageSliverList don't fit your needs, you can use DetailsPanelProvider to make sure your custom layout has access to the info it needs.

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

Also you should read https://pub.dev/documentation/master_detail_flow/latest/

![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/l1.png?raw=true) ![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/l2.png?raw=true) ![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/l3.png?raw=true)

![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/d1.png?raw=true) ![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/d2.png?raw=true) ![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/d3.png?raw=true)

![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/m1.png?raw=true) ![Screeshot](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/m2.png?raw=true)

![Video](https://github.com/2-5-perceivers/flutter-master-detail-flow/blob/master/images/demo_video.mp4?raw=true)