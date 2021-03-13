# FetchRewards Internship Exercise

## Objective

This app is to meet the requirements for the FetchRewards internship position coding exercise. It connects with the SeatGeek API to download a list of events and displays them in a UITableView. Tapping an event shows a details page and allows the user to add the event to their favorites. User favorites are persisted between app launches and the UI updates and shows which events are favorites back in the list of events. There is also a search bar that allows the user to search the SeatGeek API directly to receive a list of relevant events.

Uses CocoaPods for third party libraries. Please run 'pod install' to download and install relevant pods before building.

### Details

* Built with Swift and Xcode 12.4
* App supports iOS 12 and above
* Utilizes design patterns MVC, protocols and delegates, and the coordinator pattern for navigation
* UI designed with Storyboards, with some extras done programmatically
* User Favorites persisted via UserDefaults
* Native use of URLSession for connecting to the SeatGeek API
* Unit tests for MobileService class with mock URLSession and data, and for adding and removing event favorites

### Third Party libraries used

* SDWebImage - Used for loading images from URLs
* Mocker - Used for testing the MobileService class and mocking connecting with the API so tests are not reliant on any network connection

### Final Notes

There are additional features I wanted to add, but sacrificed for the sake of time. If this were a real project, I'd implement an infinite scroll for the UITableView so that the user could continue to scroll through the list from the API and the app would dynamically load each page seamlessly. Some foundational code was initially added for this. 

I would also create a section that allows the user to filter to show only their Favorites, and also search only their Favorites instead of the entire SeatGeek API. There is also some additional foundational code for this already. The API however does not allow a search query while also filtering for ids. While not impossible to solve, it was going to take an additional amount of time I felt were better spent elsewhere. 

Another area I felt could use improvement would be error handling, especially from the network calls. The user is shown an alert when there is an error, but it doesn't offer a way to try again, nor does it have specific error types with data for debugging.

I also had issues with keeping iOS 12 support when trying to use images for things like the add to favorites icon, since iOS 12 does not support native SF Symbols. On iOS 12 the icon is functional, but looks off. I'd spend some time adjusting the UI and the icon to make sure it looked perfect for both iOS 12 and iOS 13+.

Finally, I would add further Unit Tests for the view controllers, but I decided to only focus on essential logic of working with the API and working with Favorites.
