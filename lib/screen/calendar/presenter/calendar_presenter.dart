import 'package:scrollable_clean_calendar/utils/extensions.dart';
import 'package:stella_stays/screen/calendar/entity/calendar_state_model.dart';
import 'package:stella_stays/stella_stays.dart';
import 'package:stella_stays_gql/model.dart';

class CalendarPresenter {
  CalendarPresenter._();

  /// provider to control state
  static final provider =
      StateNotifierProvider<Watcher, CalendarStateModel>((ref) {
    return Watcher();
  });

  static void updateInitialSelection(List<Day> losDays, DateTime date,
      CalendarStateModel changes, List<DateTime> dt, WidgetRef ref) {
    Day pd = getDay(losDays, date, changes);
    bool falls = false;
    Duration? sub;
    for (DateTime d in dt) {
      if (d.isAfter(date)) {
        if (sub == null) {
          sub = d.difference(date);
        } else {
          sub =
              sub.compareTo(d.difference(date)) < 0 ? sub : d.difference(date);
        }
        if (d.isSameDayOrBefore(DateTime.parse(changes.df.format(date))
            .add(Duration(days: int.tryParse(pd.los ?? '1') ?? 1)))) {
          falls = true;
          break;
        }
      }
    }
    if (!falls) {
      ref.read(CalendarPresenter.provider.notifier)
        ..updateStartDate(date)
        ..updateEndDate(null)
        ..updateLosEnd(
            date.add(Duration(days: int.tryParse(pd.los ?? '1') ?? 1)))
        ..updateMaxLos(sub != null ? date.add(sub) : null);
    }
  }

  static Day getDay(
      List<Day> losDays, DateTime date, CalendarStateModel change) {
    DateTime s = DateTime.parse(change.df.format(date));
    Day day = losDays.firstWhere(
      (element) {
        DateTime e = DateTime.parse(element.day ?? '');
        return e.microsecondsSinceEpoch == s.microsecondsSinceEpoch;
      },
      orElse: () => Day(day: '', los: '1'),
    );
    return day;
  }
}

class Watcher extends StateNotifier<CalendarStateModel> {
  Watcher() : super(CalendarStateModel());

  void updateStartDate(DateTime? value) {
    state = state.copyWith(
        startRange: value,
        endRange: state.endRange,
        losEnd: state.losEnd,
        maxLos: state.maxLos);
  }

  void updateEndDate(DateTime? value) {
    state = state.copyWith(
        endRange: value,
        startRange: state.startRange,
        losEnd: state.losEnd,
        maxLos: state.maxLos);
  }

  void updateLosEnd(DateTime? value) {
    state = state.copyWith(
        losEnd: value,
        endRange: state.endRange,
        startRange: state.startRange,
        maxLos: state.maxLos);
  }

  void updateMaxLos(DateTime? value) {
    state = state.copyWith(
        maxLos: value,
        endRange: state.endRange,
        losEnd: state.losEnd,
        startRange: state.startRange);
  }

  void reset() {
    state = CalendarStateModel();
  }
}
