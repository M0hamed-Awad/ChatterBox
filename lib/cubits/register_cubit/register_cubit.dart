import 'package:bloc/bloc.dart';
import 'package:chatter_box_app/models/user_profile_model.dart';
import 'package:chatter_box_app/services/auth/auth_service.dart';
import 'package:chatter_box_app/services/database_service.dart';
import 'package:chatter_box_app/services/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register(
      {required String username,
      required String email,
      required String userProfileImagePath,
      required String password}) async {
    final AuthService authService = AuthService();

    emit(RegisterLoading());

    try {
      await authService.registerWithEmailAndPassword(
        email: email,
        password: password,
      );

      String profileImageURL = await _getUserProfilePicURL(
        userProfileImagePath: userProfileImagePath,
        currentUserUid: authService.currentUser!.uid,
      );

      try {
        await _saveUserProfileData(
          authService,
          username,
          email,
          profileImageURL,
        );
      } catch (e) {
        emit(RegisterFailure("Unable to upload the user profile image."));
        throw Exception("Unable to upload the user profile image.\nError: $e");
      }
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(RegisterFailure(
        AuthService().registrationExceptionsHandling(exception: e),
      ));
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    throw Exception("Unable to register the user: ${e.toString()}");
    }
  }

  Future<void> _saveUserProfileData(
    AuthService authService,
    String username,
    String email,
    String profileImageURL,
  ) async {
    final DatabaseService databaseService = DatabaseService();
    await databaseService.createUserProfile(
      userProfileModel: UserProfileModel(
        uid: authService.currentUser!.uid,
        name: username,
        email: email,
        profileImageURL: profileImageURL,
      ),
    );
  }

  Future<String> _getUserProfilePicURL({
    required String userProfileImagePath,
    required String currentUserUid,
  }) async {
    final StorageService storageService = StorageService();
    return userProfileImagePath.startsWith("assets/")
        // Uploading Profile Image from local Avatars assets.
        ? await storageService.uploadImageFromAssets(
            assetPath: userProfileImagePath,
            // Getting the current User UID.
            uid: currentUserUid,
          )
        // Uploading Profile Image from The Device.
        : await storageService.uploadImageFromDevice(
            imagePath: userProfileImagePath,
            // Getting the current User UID.
            uid: currentUserUid,
          );
  }
}
