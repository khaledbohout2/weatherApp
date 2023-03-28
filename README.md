# weatherApp
weatherApp It's an iOS project which displaying a list of cities saved locally using core data 

The project is built using MVVM-C architecture where:  
- M represents Model to hold the data entities,
- VM represents ViewModel to handle the flow and work with the different services,
- V represents View to hold the UI,
- C represents Coordinator to handle the navigation and passing data between different modules,
 and it's built with using Clean Architecture to keep the SOLID principle applied and make the project scalable.
 It's using combine framework to apply observer pattern.
 It's built by applying clean architecture by using use cases, repositories to deal with the services.

List of Modules
1 cities List handling the process of fetching the cities list from core data, displaying that list to UI.\
2 weather Details displaying the weather details data\
3 search screen handling the user searches for new cities\
4 city history screen, handles all past requests for specific city\

Technologies Project is created using:
• MVVM-C Architecture
• Combine framework
• Clean Architecture
• iOS SDK 15.0
• Swift version 5.5
• XCode version 14.0
- core data
