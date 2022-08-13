import 'package:apex/data/local/hat.dart';
import 'package:apex/data/local/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'pin_event.dart';
part 'pin_state.dart';

class PinBloc extends Bloc<PinEvent, PinState> {
  PinBloc() : super(PinInit()) {
    on<SaveEvent>(_save);
    on<LoginEvent>(_login);
  }
  final AppStorage _appStorage = AppStorage.instance;
  final BlackHat _blackHat = BlackHat();

  _save(SaveEvent event, Emitter<PinState> emit) async {
    emit(PinLoading());

    var p = _blackHat.encryptWithAES(
        event.pincode + (dotenv.env["COMPLETION"] ?? ""), event.token);
    _appStorage.savePinCode(event.pincode + (dotenv.env["COMPLETION"] ?? ""));
    _appStorage.saveRequestToken(p.base64);
    emit(PinSuccess());
  }

  _login(LoginEvent event, Emitter<PinState> emit) async {
    emit(PinLoading());
    if (event.pincode == await _appStorage.getPinCode()) {
      emit(PinSuccess());
    } else {
      emit(PinFailed(error: "Incorrect Pin"));
    }
  }
}
