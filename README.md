# MasterNumber
[Please click here to watch the video of the app](https://youtu.be/2sUuXRLHLKI)

## Prerequisites

Before using any of the view controllers in this project, ensure that you have the following prerequisites set up:

- Firebase SDK installed and configured in your project.
- Required Firebase modules imported (import Firebase, import FirebaseFirestore, import FirebaseStorage).
- Xcode and an iOS development environment compatible with the Swift language.

## Installation

To integrate any of the view controllers into your project, follow the steps below:

1. Copy the source code of the desired view controller(s) into your Xcode project.
2. Make sure you have imported the necessary frameworks and libraries.
3. Set up the required dependencies and configurations (e.g., Firebase SDK).
4. Create an instance of the chosen view controller and present it in your app's view hierarchy.
5. Customize the view controller as needed, referring to the usage instructions provided for each specific view controller.

## 1. Sign Up View Controller

<p align="center">
  <img src="https://github.com/oykuhazer/MasterNumber/assets/130215854/8009c21d-ee74-480e-99d2-2f5efa8a3d8f" alt="zyro-image" width="200" height="400">
</p>

This is a sample `SignUpViewController` class that demonstrates a sign-up screen in iOS using UIKit and Firebase. The view controller includes text fields for email and password input, a sign-up button, a login button, and a profile image view. It utilizes Firebase for user authentication and Firestore for data storage.

### Usage

- Create an instance of `SignUpViewController` and present it in your app's view hierarchy.
- Fill in the email and password fields.
- Tap the "Sign Up" button to create a new user account.
- If the sign-up is successful, the user's information is saved to Firestore, and a success alert is displayed.
- If a profile image is selected, it is uploaded to Firebase Storage under the "profileImages" directory.

## 2. Log In View Controller

<p align="center">
  <img src="https://github.com/oykuhazer/MasterNumber/assets/130215854/aa7b3187-b7e9-4004-9061-2778af7be795" alt="zyro-image" width="200" height="400">
</p>

This is a sample `LogInViewController` class that demonstrates a login screen in iOS using UIKit and Firebase. The view controller includes text fields for email and password input, a login button, and a sign-up button. It utilizes Firebase for user authentication and Firebase Storage for retrieving a user's profile image.

### Usage

- Create an instance of `LogInViewController` and present it in your app's view hierarchy.
- Fill in the email and password fields.
- Tap the "Log In" button to authenticate the user using Firebase Auth.
- If the login is successful, the user's profile image is retrieved from Firebase Storage.
- A new `ViewController` is created, and the retrieved username and profile image are set as properties.
- The `ViewController` is pushed onto the navigation stack.

## 3. View Controller

<p align="center">
  <img src="https://github.com/oykuhazer/MasterNumber/assets/130215854/61a0eacd-ffc7-4c8c-bb04-9fe258a2d60b" alt="Simulator Screenshot - iPhone 14 Pro - 2023-07-07 at 15 47 29" width="200" height="400">
</p>

This is a sample `ViewController` class that demonstrates a view controller in iOS using UIKit. The view controller includes a gradient background, buttons with custom colors, a label for displaying a greeting message, an image view for the profile image, and a game menu with buttons.

### Usage

- Create an instance of `ViewController` and present it in your app's view hierarchy.
- The view controller will display a gradient background using purple, orange, and yellow colors.
- Three buttons will be created with custom colors: `hwtpbutton`, `playbutton`, and `exitbutton`.
- The `hwtpbutton` and `playbutton` buttons will have labels and icons, while the `exitbutton` will only have a label.
- The buttons will be positioned in the view using the `centerX`, `centerY`, `buttonSize`, and `buttonSpacing` properties.
- A label will be created to display a greeting message with the username.
- An image view will be created to display the `profileImage`.
- A circular view will be created as a background for the profile image.
- A game menu container view will be created with a label for the menu title.
- The buttons, labels, and icons will be added as subviews to the view controller's view.
- Constraints will be set to position the views and icons correctly.

## 4. HWTPVC (How to Play View Controller)

<p align="center">
  <img src="https://github.com/oykuhazer/MasterNumber/assets/130215854/14c2f900-c425-46e8-a754-56b3c7c33dad" alt="Simulator Screenshot - iPhone 14 Pro - 2023-07-07 at 15 50 19"width="200" height="400">
</p>

This is a sample `HWTPVC` (How to Play View Controller) class that demonstrates a view controller in iOS using UIKit. The view controller is used to display a tutorial or instructions on how to play a game. It includes multiple pages of text with a gradient background, a page control for navigation, and animated wave layers in the background.

### Usage

- Create an instance of `HWTPVC` and present it in your app's view hierarchy.
- The view controller will display multiple pages of text, each with a gradient background.
- The text is provided in the `labelContents` array.
- The view controller includes a page control at the bottom for navigation between pages.
- Animated wave layers are added as background elements.
- The timer automatically scrolls to the next page every 5 seconds.
- The user can manually navigate between pages by tapping on the page control.
- A "Play Game" button is provided to start the game.
- The view controller uses segues to transition to the game screen.

  ## 5. PGVC (Play Game View Controller)

<p align="center">
  <img src="https://github.com/oykuhazer/MasterNumber/assets/130215854/933caf45-ae10-438e-be0c-7cf2ce4f8512" alt="Simulator Screenshot - iPhone 14 Pro - 2023-07-07 at 15 52 18" width="200" height="400">
  <img src="https://github.com/oykuhazer/MasterNumber/assets/130215854/e05a4eb0-8eb5-4ca2-b519-13534622f857" alt="Simulator Screenshot - iPhone 14 Pro - 2023-07-07 at 15 52 28" width="200" height="400">
  <img src="https://github.com/oykuhazer/MasterNumber/assets/130215854/4dc936de-889a-4065-a539-f83847ed7710" alt="Simulator Screenshot - iPhone 14 Pro - 2023-07-07 at 15 53 54" width="200" height="400">
  <img src="https://github.com/oykuhazer/MasterNumber/assets/130215854/5ca3aadb-8b0c-44d5-a292-59f75e274a84" alt="Simulator Screenshot - iPhone 14 Pro - 2023-07-07 at 15 54 39" width="200" height="400">
</p>

In this project, there is a game where the user needs to guess a specific number. The game provides an interface for the user to enter a number and gives feedback based on their guesses.

### Features

- Text field for the user to enter a number
- Button to submit the number
- Labels to display hints about the accuracy of the guess
- Counter to show the number of remaining attempts
- Different visuals based on winning or losing the game

### Usage

1. When the app starts, a text field for entering a number and an "Enter" button will be displayed.
2. Enter the number of digits in the text field for the desired number to guess.
3. When the "Enter" button is tapped, the game starts, and a countdown begins.
4. After the countdown completes, a text field for making the guess and a hint label will be displayed.
5. Enter a number in the text field for the guess and tap the "Guess" button.
6. If the guess is correct, an image and message indicating a win will be displayed, along with the "House" and "Exit" buttons.
7. If the guess is incorrect, the remaining attempt count will decrease, and feedback will be given.
8. When there are no remaining attempts, an image and message indicating a loss will be displayed, along with the "House" and "Exit" buttons.

## 6. GalleryViewController

<p align="center">
  <img src="https://github.com/oykuhazer/MasterNumber/assets/130215854/7ac8e478-1818-4e9c-bd5c-44f3259920eb" alt="Simulator Screenshot - iPhone 14 Pro - 2023-07-07 at 15 37 30" width="200" height="400">
</p>


The GalleryViewController is a view controller that displays a collection of images. It provides a delegate protocol `GalleryViewControllerDelegate` for notifying the selection of an image.

### Usage

1. Include the UIKit framework in your project.
2. Create a class that conforms to the `GalleryViewControllerDelegate` protocol and implement the `didSelectImage(_:)` method.
3. Create a `GalleryViewController` class. This class should inherit from `UIViewController` and conform to the `UICollectionViewDataSource` and `UICollectionViewDelegateFlowLayout` protocols.
4. Define a weak reference to the delegate in the `GalleryViewController` class.
5. In the `viewDidLoad()` method, configure the layout of the collection view and create the collection view itself.
6. Populate the collection view with images by implementing the necessary collection view data source methods (`numberOfItemsInSection`, `cellForItemAt`).
7. Handle the selection of an item in the collection view by implementing the `collectionView(_:didSelectItemAt:)` method. Retrieve the selected image and call the delegate method to notify the selection.
8. Optionally, customize or subclass the `ImageCell` class to represent each cell in the collection view.

By following these steps, you can display a collection of images using the `GalleryViewController` and handle the selection of an image using delegation.

## 7. ImageCell

This is a simple example of a custom `UICollectionViewCell` subclass called `ImageCell`. The cell contains a `UIImageView` to display an image. The code snippet provided demonstrates how to set up the image view within the cell.

### Usage

To use the `ImageCell` class in your project, follow these steps:

1. Copy the code for the `ImageCell` class into your project.
2. Make sure you have imported the UIKit framework in the file where you plan to use the `ImageCell` class.
3. Create an instance of `ImageCell` and add it to your `UICollectionView`.

Explanation:

The `ImageCell` class is a subclass of `UICollectionViewCell`. It contains a `UIImageView` called `imageView`, which is responsible for displaying the image.
