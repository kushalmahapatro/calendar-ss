import 'package:stella_stays/screen/booking/entity/booking_state_model.dart';
import 'package:stella_stays/stella_stays.dart';
import 'package:stella_stays_gql/model.dart';

class BookingPresenter {
  BookingPresenter._();

  /// provider to control state
  static final provider =
      StateNotifierProvider<Watcher, BookingStateModel>((ref) {
    return Watcher();
  });
}

class Watcher extends StateNotifier<BookingStateModel> {
  Watcher() : super(BookingStateModel());

  void updateStartDateStay(String value) {
    state = state.copyWith(startDateStay: value);
  }

  void updateEndDateStay(String value) {
    state = state.copyWith(endDateStay: value);
  }

  void updateStartDateUnit(String value) {
    state = state.copyWith(startDateUnit: value);
  }

  void updateEndDateUnit(String value) {
    state = state.copyWith(endDateUnit: value);
  }

  void changeDrawerState(List<DateTime>? ud, List<Day>? los) {
    state = state.copyWith(ud: ud, los: los);
  }

  void reset() {
    state = BookingStateModel();
  }
}
