import 'package:apex/respository/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  VerifyOtpBloc() : super(VerifyOtpInit()) {
    on<VerifyEvent>(_verify);
    on<ResendEvent>(_resend);
  }
  final ApiRepository _apiRepository = ApiRepository.instance;
  _verify(VerifyEvent event, Emitter<VerifyOtpState> emit) async {
    emit(VerifyOtpLoading());
    var request = await _apiRepository.verifyEmail(event.email, event.token);

    if (request.item1 != null) {
      emit(VerifyOtpSuccess(email: request.item1?.email ?? ""));
    } else {
      emit(VerifyOtpFailed(error: request.item2 ?? ""));
    }
  }

  _resend(ResendEvent event, Emitter<VerifyOtpState> emit) async {
    emit(VerifyOtpLoading());
    var request = await _apiRepository.getToken(event.email);

    if (request.item1 != null) {
      emit(VerifyOtpSuccess(email: request.item1?.token ?? ""));
    } else {
      emit(VerifyOtpFailed(error: request.item2 ?? ""));
    }
  }
}
