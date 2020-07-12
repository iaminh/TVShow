## TV show manager
Sample code of the case study assignment I did for an interview for an iOS dev position

Used tech: Swift, MVVM + Coordinators(named `Modules` in app), ReactiveKit/Bond

## Documentation
For this assignment, the goal is to create the “TV show manager app”. An app for people who watch so many tv shows that they can’t keep track of all of them without the help of an app.

The frontend part consists of the three views shown in the mockup. The mockup shows just an example of what the app could look like. Feel free to change the design as you see fit.

The first view let’s the user choose between adding a new tv show and showing the list of already added shows. If the user taps the “Add new TV show” button, he or she should be taken to the “Add new TV show” view, shown in the middle of the mockup. Tapping on the “Show list of added shows” button should take the user the “TV show list” view, shown on the right of the mockup.

In the “Add new TV show” view, once the user entered all the needed information (Title (String), Year of release (Number), Number of seasons (Number)) and taps the save button, the information should be sent to the server and saved in the database and the user should be taken back to the first view. In order to do this you need to create a PFObject with the class named “TVShow” and store the title, year of release and number of seasons in columns called “title”, “year” and “seasons”.

The third view (“TV show list”) should show a list of all tv shows which are in the database.

Frontend-Backend communication:

The app must communicate with the server in order to create & store the data the user entered. In this assignment this would be a movie object. The backend uses the Parse framework so the app needs to be integrated with the Parse iOS SDK in order to communicate to the server. Parse is simply a Backend solution that simplifies the interaction between the client and the server by offering a simple API Interface to manipulate the database. Use Parse SDK for iOS to connect to the Parse API. You don’t need to setup anything or care about the database. You should use the information attached to this task to initialize your Parse SDK.

For your information, Parse uses MongoDB as a NoSQL Database, so you don’t need to care about the schema or defining a class. Parse will create a new Class and its Fields at that time you save an object to it.

Here are some resources that you might want to read:

- What is Parse server: https://parseplatform.org
- Parse iOS SDK: https://github.com/parse-community/Parse-SDK-iOS-OSX
- iOS SDK getting started: ​https://docs.parseplatform.org/ios/guide/

This is the information you might need when configuring the Parse iOS SDK:

- Application ID: UvBvjdPeATFfYW9PeMjuoyX0ZGkD9XVY6NJAwshV
- Client Key: rxbpcYTOYya1NXcMbyaXNdLOCNs2VwY86OZ6w9ZE
- ServerURL: https://parseapi.back4app.com/