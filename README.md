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

Finally, I would add further Unit Tests for the view controllers, but I decided to only focus on essential logic of working with the API and working with Favorites.
