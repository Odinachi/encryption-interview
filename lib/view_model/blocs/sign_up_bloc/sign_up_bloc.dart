import 'package:apex/respository/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInit()) {
    on<RegisterEvent>(_register);
  }
  final ApiRepository _apiRepository = ApiRepository.instance;
  _register(RegisterEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    var request = await _apiRepository.getToken(event.email);

    if (request.item1 != null) {
      emit(SignUpSuccess(email: request.item1?.token ?? ""));
    } else {
      emit(SignUpFailed(error: request.item2 ?? ""));
    }
  }
}
