import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_user_profile_usecase.dart';
import '../../domain/entity/user_entity.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;

  ProfileBloc(this.getUserProfileUseCase) : super(ProfileInitial()) {
    on<LoadUserProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final user = await getUserProfileUseCase();
        emit(ProfileLoaded(user));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}
