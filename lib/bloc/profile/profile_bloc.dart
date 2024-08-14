import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/profile/profile_event.dart';
import 'package:shopping_app/bloc/profile/profile_state.dart';
import 'package:shopping_app/models/user.dart';
import 'package:shopping_app/repositories/user_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;

  ProfileBloc({required this.userRepository}) : super(ProfileLoading()) {
    on<LoadUserProfile>(_onLoadUserProfile);
    on<UpdateUserProfile>(_onUpdateUserProfile);
  }

  Future<void> _onLoadUserProfile(LoadUserProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final User user = await userRepository.fetchUserProfile();
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(const ProfileError('Failed to load profile'));
    }
  }

  Future<void> _onUpdateUserProfile(UpdateUserProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final User updatedUser = await userRepository.updateUserProfile(
        name: event.name,
        email: event.email,
        profilePictureUrl: event.profilePictureUrl,
      );
      emit(ProfileLoaded(updatedUser));
    } catch (e) {
      emit(const ProfileError('Failed to update profile'));
    }
  }
}
