# Chatter Box 💬📱

Chatter Box is a chat application designed to connect users through real-time messaging. Users can create accounts, and chat with others seamlessly. This app leverages Firebase for authentication, storage, and real-time data handling, ensuring secure and efficient interactions.

## Features

- **User Registration & Authentication**:
  - New users can sign up by providing an email, username, and password.
  - Users can upload a profile image directly from their device (using `image_picker`) or choose from a collection of custom avatars.
  - Profile images are uploaded and stored securely in Firebase Storage.
  - Authentication is managed via Firebase Auth, enabling secure login and account management.

- **Real-Time Messaging**:
  - Users can view a list of all registered users.
  - By selecting a user, a dedicated chat room is created where they can exchange messages in real-time.
  - Messages and chat metadata are stored in Firestore, making chat data instantly available.

- **Custom Avatars**:
  - Includes a unique collection of pre-designed avatars stored locally in the app assets.
  - Users can choose between uploading a personal image or selecting an avatar for their profile.

## Tech Stack

- **Flutter & Dart**:
  - Core framework for building a smooth and responsive UI.
  
- **Firebase**:
  - **Firebase Auth**: Manages user registration, login, and authentication.
  - **Firebase Storage**: Handles storage of profile images securely.
  - **Cloud Firestore**: Stores user profiles, chat data, and message histories.
  
- **State Management**:
  - **Cubit** (from `flutter_bloc`): Manages app states efficiently, including user profile image uploads and message exchanges.

- **Packages Used**:
  - `firebase_core` & `firebase_auth` for Firebase integration.
  - `cloud_firestore` for Firestore database.
  - `firebase_storage` for storing profile images.
  - `image_picker` for profile image selection from the device.
  - `flutter_bloc` for state management.

## Getting Started

1. **Clone the repository**:

    ```bash
    git clone https://github.com/yourusername/chatter-box.git
    cd chatter-box
    ```

2. **Install dependencies**:

    ```bash
    flutter pub get
    ```

3. **Firebase Setup**:
   - Set up a Firebase project at [Firebase Console](https://firebase.google.com/).
   - Add an Android/iOS app to your Firebase project and download the `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS).
   - Place the configuration files in the respective platform directories in your Flutter project.
   - Enable Firebase Auth, Firestore, and Storage in your Firebase project.

4. **Run the app**:

    ```bash
    flutter run
    ```

## Future Improvements

- **Image Messaging**: Enable image sending within chat for richer interactions.
- **Message Editing & Deletion**: Allow users to edit and delete their messages.
- **Notification System**: Add real-time notifications for new messages.
- **User Presence Indicator**: Show online/offline status to indicate user availability.
