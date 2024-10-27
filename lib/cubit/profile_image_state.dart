part of 'profile_image_cubit.dart';

@immutable
sealed class ProfileImageState {}

final class ProfileImageInitial extends ProfileImageState {}

final class ProfileImageLoading extends ProfileImageState {}

final class ProfileImageSuccess extends ProfileImageState {}

final class ProfileImageFailure extends ProfileImageState {
  final String errMessage;
  ProfileImageFailure(this.errMessage);
}
