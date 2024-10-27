import 'dart:math';

import 'package:chatter_box_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// Generate Material Color

MaterialColor generateMaterialColor({required Color color}) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1,
    );

//___________________________________________________________________________//

// Setup Firebase

Future<void> setupFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

//___________________________________________________________________________//

// Validations

// Username Regex
final RegExp usernameValidationRegex = RegExp(
  r"^(?=.{3,20}$)(?![_.-])(?!.*[_]{2})(?!.*[-]{2})(?!.*[.]{2})[a-zA-Z0-9._-]+(?<![_.-])$",
);

// Email Regex
final RegExp emailValidationRegex = RegExp(
  r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
);

// Password Regex
final RegExp passwordValidationRegex = RegExp(
  r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$",
);

//_____________________________________//

// Username Validation

({String errMessage, bool isExceedsValidLength}) checkUsernameLength(
    String username) {
  if (username.length > 20) {
    return (
      isExceedsValidLength: true,
      errMessage: "Username should be greater than or equal to 20."
    );
  } else if (username.length < 3) {
    return (
      isExceedsValidLength: true,
      errMessage: "Username should be less than or equal to 3."
    );
  } else {
    return (isExceedsValidLength: false, errMessage: "");
  }
}

isStartsOrEndWithSpecialCharacters(String username) {
  if (username.startsWith("-") ||
      username.endsWith("-") ||
      username.startsWith("_") ||
      username.endsWith("_") ||
      username.startsWith(".") ||
      username.endsWith(".")) {
    return true;
  } else {
    return false;
  }
}

isHavingNotAllowedSpecialCharacters(username) {
  if (!RegExp(r'^[a-zA-Z0-9._-]+$').hasMatch(username)) {
    return true;
  } else {
    return false;
  }
}

isHavingAConsecutiveSpecialCharacters(username) {
  if (RegExp(r'[_.-]{2}').hasMatch(username)) {
    return true;
  } else {
    return false;
  }
}

String? validateUsername(String? username) {
  var info = checkUsernameLength(username!);
  var isExceedsValidLength = info.isExceedsValidLength;
  var errMessage = info.errMessage;

  if (username.isNotEmpty) {
    if (usernameValidationRegex.hasMatch(username)) {
      return null;
    } else {
      if (isExceedsValidLength) {
        return errMessage;
      } else if (isStartsOrEndWithSpecialCharacters(username)) {
        return "Username cannot start or end with '.' , '_' or '-' .";
      } else if (isHavingNotAllowedSpecialCharacters(username)) {
        return "Username can only contain alphanumeric characters, '.' , '_', and '-' .";
      } else if (isHavingAConsecutiveSpecialCharacters(username)) {
        return "Username cannot contain consecutive '.' ,'_', or '-' .";
      } else {
        return "Please enter a valid Username";
      }
    }
  } else {
    return "Username field can't be empty.";
  }
}

//_____________________________________//

// Email Validation

String? validateEmail(String? email) {
  if (email?.isNotEmpty ?? false) {
    if (emailValidationRegex.hasMatch(email!)) {
      return null;
    } else {
      return "Please enter a valid Email.\nEmail should be like this eg. example@domain.com";
    }
  } else {
    return "Email field can't be empty.";
  }
}

//_____________________________________//

// Password Validation

bool containsNoLetters(String password) {
  return RegExp(r'^[^A-Za-z]*$').hasMatch(password);
}

bool containsNoDigits(String password) {
  return RegExp(r'^[^0-9]*$').hasMatch(password);
}

String? validatePassword(String? password) {
  if (password?.isNotEmpty ?? false) {
    if (passwordValidationRegex.hasMatch(password!)) {
      return null;
    } else if (containsNoDigits(password)) {
      return "Password should have at least 1 digit.";
    } else if (containsNoLetters(password)) {
      return "Password should have at least 1 letter.";
    } else {
      return "Please enter a valid Password.";
    }
  } else {
    return "Email field can't be empty.";
  }
}

//___________________________________________________________________________//

// Generate Chat ID

String generateChatId({
  required String uid1,
  required String uid2,
}) {
  List<String> uids = [uid1, uid2];
  uids.sort(); // Ensures that the order is consistent
  String chatId = uids.join("");
  return chatId;
}
