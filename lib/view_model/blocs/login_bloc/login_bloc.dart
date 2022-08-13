import 'package:apex/data/local/storage.dart';
import 'package:apex/respository/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInit()) {
    on<Login>(_login);
    on<CheckAuth>(_check);
  }
  final ApiRepository _apiRepository = ApiRepository.instance;

  _check(CheckAuth event, Emitter<LoginState> emit) async {
    var p = AppStorage.instance.getPinCode();
    if (p != null) {
      emit(HasAuth());
    }
  }

  _login(Login event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    var request = await _apiRepository.login(event.email, event.password);

    if (request.item1 != null) {
      emit(LoginSuccess(token: request.item1?.token ?? ""));
    } else {
      emit(LoginFailed(error: request.item2 ?? ""));
    }
  }
}
