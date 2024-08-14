import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadUserProfile extends ProfileEvent {}

class UpdateUserProfile extends ProfileEvent {
  final String name;
  final String email;
  final String profilePictureUrl;

  const UpdateUserProfile({
    required this.name,
    required this.email,
    required this.profilePictureUrl,
  });

  @override
  List<Object> get props => [name, email, profilePictureUrl];
}
