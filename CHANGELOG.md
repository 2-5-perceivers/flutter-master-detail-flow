## 3.0.0
* Rewrote from scratch to make it simpler, more powerful and more performant
* Using internal navigator for better semantics
* Replaced MasterDetailFlow with MDScaffold
* Now master items can be any widget you want
* Initial page now uses an ID so the order does not count
* Moved customization to a MDThemeData class, that can be provided to the entire app by using the new MDTheme widget
* Removed the previous master items
* Removed the previous details item
* New MDItem
* New MDPadding
* New DetailsPageScaffold
* New DetailsPageSliverList
* New FlowView widget and a MDController, that represent the logic of the MDScaffold, for custom flows
* New MDBreakpoint enum-like class to help with some predefined values
* New ViewMode enum to represent the current view mode, can be accessed either from MDController or from DetailsPanelProvider
* Added the option to remove the app bar in DetailsPageSliverList by using MDAppBarSize.none
* Improved documentation
* Updated dependencies. Sorry for being late
* Better example

## 2.3.0
* Customizable animation duration
* New and improved example
* More customization options and improved looks

## 2.2.0
* Added subtitles for masterItem
* You can now also customize the app bar size in master view when collapsed
* New example

## 2.1.0
* Create new header and divider widgets

## 2.0.1
* Update README.md

## 2.0.0
* Completly changed the api to make it simpler and more powerfull.
* Droped the support for custom builders in master page

## 1.0.1
* Updated dependencies
* Improved README.md
* Formatting

## 1.0.0

* Initial release
