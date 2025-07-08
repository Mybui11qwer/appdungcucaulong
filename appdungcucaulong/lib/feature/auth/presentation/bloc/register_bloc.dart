import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/register_usecase.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc(this.registerUseCase) : super(RegisterInitial()) {
    on<SubmitRegister>((event, emit) async {
      emit(RegisterLoading());
      try {
        await registerUseCase(event.dto);
        emit(RegisterSuccess());
      } catch (e) {
        emit(RegisterFailure(e.toString()));
      }
    });
  }
}
