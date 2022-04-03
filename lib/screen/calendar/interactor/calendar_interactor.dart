import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:stella_stays/screen/booking/presenter/booking_presenter.dart';
import 'package:stella_stays/screen/calendar/entity/calendar_state_model.dart';
import 'package:stella_stays/screen/calendar/presenter/calendar_presenter.dart';
import 'package:stella_stays/screen/calendar/routes/calendar_routes.dart';
import 'package:stella_stays/stella_stays.dart';

class CalendarInteractor {
  ClickFunction onClearClick(WidgetRef ref, CleanCalendarController? controller,
      BuildContext context) {
    return ClickFunction('clear clicked', onClick: () {
      ref.read(CalendarPresenter.provider.notifier).reset();
      if (controller != null) controller.clearSelectedDates();
    });
  }

  ClickFunction cancelClick(WidgetRef ref, CleanCalendarController? controller,
      BuildContext context) {
    return ClickFunction('clear clicked', onClick: () {
      ref.read(CalendarPresenter.provider.notifier).reset();
      if (controller != null) controller.clearSelectedDates();
      CalendarRoute().goback(context);
    });
  }

  ClickFunction onApplyClick(
      CalendarStateModel changes, WidgetRef ref, BuildContext context,
      {bool isCondition = false}) {
    return ClickFunction('on apply click', onClick: () {
      if (isCondition) {
        ref.read(BookingPresenter.provider.notifier)
          ..updateEndDateStay(changes.endDate)
          ..updateStartDateStay(changes.startDate);
      } else {
        ref.read(BookingPresenter.provider.notifier)
          ..updateEndDateUnit(changes.endDate)
          ..updateStartDateUnit(changes.startDate);
      }

      ref.read(CalendarPresenter.provider.notifier).reset();

      CalendarRoute().goback(context);
    });
  }
}
