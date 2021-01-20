# Artly

How to run:
1) download/clone repo
2) open Artly.xcodeproj using XCode
3) build freameworks using their schemes: Extensions -> Models -> NetworkingModule -> Persistance
4) build and run main scheme.

# Artly

Required features:
• Content should be backend driven. You can host one/more json file/s on gist.github.com or any other service and use it as the host of the data from your app (or any online REST alternative)
• Use UINavigationController and UITableView/UICollectionView displaying list of items. Each cell should consist of backend driven image and title. After tapping, selected content should be shown on the details screen with more information. Aside from this, there should be at least one screen presented modally
• Possibility to mark the item as “favourite” and filter the list to show only favourite items.
• There should be mechanism to persist favourites between app launches. You don’t
have to persist whole objects – implementation is up to you. You may use UserDefaults
but make it scalable
• Have a point of synchronization (e.g. making two concurrent network requests and
waiting for both of them to finish)
• Handle loading and error states
Technical requirements:
• Do not use SwiftUI and/or Combine. We value the knowledge but for now we’re still relying on UIKit.
• Construct your UI in code and use Auto Layout. Do not use Interface Builder.
• Do not use any 3rd party frameworks
• Support the latest major iOS version plus one below (if iOS 13.x is the newest one,
please support iOS 12.x as well)
• Clean code with production grade coding style
• Write Unit Tests, you don’t have to test everything but please make sure your code is
testable.

Technical requirements:
• Do not use SwiftUI and/or Combine. We value the knowledge but for now we’re still relying on UIKit.
• Construct your UI in code and use Auto Layout. Do not use Interface Builder.
• Do not use any 3rd party frameworks
• Support the latest major iOS version plus one below (if iOS 13.x is the newest one,
please support iOS 12.x as well)
• Clean code with production grade coding style
• Write Unit Tests, you don’t have to test everything but please make sure your code is
testable.
• UI Tests are optional but nice to have
• We do not enforce any design pattern – use whatever you think suits your project best.
• README explaining how to run the project

Considerations:
• The development should be approached as production code. Do not leave unnecessary comments and unused methods. Be consistent in your code
• Privilege quality over quantity
• Good engineering principles
• Follow Apple Human Interface Guidelines
as long as the appropriate data handling is in place.
