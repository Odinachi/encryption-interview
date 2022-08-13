import 'package:apex/respository/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInit()) {
    on<FetchDashBoard>(_fetch);
  }
  final ApiRepository _apiRepository = ApiRepository.instance;
  _fetch(FetchDashBoard event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    var request = await _apiRepository.dashboard();

    if (request.item1 != null) {
      emit(DashboardSuccess(message: request.item1?.secret ?? ""));
    } else {
      emit(DashboardFailed(
          error: request.item2 ?? "Fail to get you amazing quote"));
    }
  }
}
