# iOS MessageBoard

This is a simple message board app that displays XML data from an HTTP
GET function and properly formats it in a table view.

## How to run
Open the project using Xcode by running the MessageBoard.xcodeproj
file. Once the project is loaded on Xcode it can be run using the
provided run button in an iOS simulator.

## Notes
-This app includes a refresh navigation button at the top left of the
application to refresh the list of messages.

-Once a new message is added using the add button and form provided in
 the app it will NOT refresh the list of messages until the user uses
 the refresh button.
 
-Date is formatted as the following: MONTH DAY, YEAR, HH:MIN:SEC (AM/PM)
 
-The table view of messages only shows the title of the message and
  the formated date it was created at. When you click on the message
  it will reveal the title, created_at formated date, and body of the message.
