# flutter_assignment2

A Futter project developed for the module of Advanced App Development in Saxion.

## Requisites

For running this application, you will need to have installed Flutter and add it in your path. You will also need JDK and JRE in your enviroment variables.
If there is any problem, run in terminal the command: flutter doctor
When you clone the project, I suggest using VS code and opening the project there. You will need to install the Flutter and Dart extensions.
This is a good tutorial: https://rushalisarkar.medium.com/complete-flutter-set-up-in-vs-code-57df49adae21

## Running the project

To run this project, firstly it is needed to run:
    'flutter pub get'
to install the dependencies.

Then, in VS Code for example, we can run it from the main.dart file.
I recommend using a physical device to debug the application. Despite this, the connection to the API is done in a way that it works with a virtual device (VM).

### Connecting with the API
To connect with the API is necessary to run it in the device where we are going to run the Flutter application. The API is runneable by a Docker command. How to do that is explained in its Readme.md file.
When we are running the backend, we can simply run a virtual device in the same machine and the connection will be established, since the calls in the Flutter application are written so the ports and IPs match.

## Testing
I recommend using the tools that VSCode offers to run the tests. On the other hand, we can also run the tests by the command line. Just paste this when you are in the root directory:
    flutter test ./test

