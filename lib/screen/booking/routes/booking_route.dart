import 'package:stella_stays/screen/booking/presenter/booking_presenter.dart';
import 'package:stella_stays/screen/calendar/view/calendar_view.dart';
import 'package:stella_stays/stella_stays.dart';
import 'package:stella_stays_gql/model.dart';

class BookingRoute {
  void goToCalendar(BuildContext context, WidgetRef ref,
      {List<DateTime>? dt, List<Day>? losDays, bool openDrawer = false}) {
    if (openDrawer) {
      ref
          .read(BookingPresenter.provider.notifier)
          .changeDrawerState(dt, losDays);
      Scaffold.of(context).openEndDrawer();
    } else {
      showModalBottomSheet<bool>(
        elevation: 8,
        isScrollControlled: true,
        enableDrag: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height - 100,
            child: CalendarView(
              unavailableDays: dt,
              los: losDays,
            ),
          ).circularBorder;
        },
        context: context,
      );
    }
  }
}
