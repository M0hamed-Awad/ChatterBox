import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Login
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  String loginExceptionsHandling({
    required FirebaseAuthException exception,
  }) {
    if (exception.code == 'user-not-found') {
      return "No user found for that email.";
    } else if (exception.code == 'wrong-password') {
      return "Wrong password provided for that user.";
    } else if (exception.code == 'invalid-credential') {
      return "The email or password is incorrect. Please try again.";
    } else {
      return "An unknown error occurred. Please try again.";
    }
  }

  // Register
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Logout
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
