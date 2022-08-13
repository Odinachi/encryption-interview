import 'package:apex/models/resgister_response.dart';
import 'package:apex/res/assets.dart';
import 'package:apex/respository/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInit()) {
    on<CompleteSignUp>(_register);
  }
  final ApiRepository _apiRepository = ApiRepository.instance;
  _register(CompleteSignUp event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    var request = await _apiRepository.register(RegisterUser(
        email: event.email,
        password: event.password,
        country: event.country.toUpperCase(),
        fullName: event.fullName,
        device: await AppAssets.getDeviceId()));

    if (request.item1 != null) {
      emit(LocationSuccess(token: request.item1?.token ?? ""));
    } else {
      emit(LocationFailed(error: request.item2 ?? ""));
    }
  }
}
