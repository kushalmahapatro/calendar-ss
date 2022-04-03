import 'package:stella_stays/screen/booking/routes/booking_route.dart';
import 'package:stella_stays/stella_stays.dart';
import 'package:stella_stays_gql/model.dart';

class BookingInteractor {
  ClickFunction onStayBookingClick(
      List<DateTime> dt, List<Day> losDays, BuildContext context, WidgetRef ref,
      {bool openDrawer = false}) {
    return ClickFunction('book your stay clicked', onClick: () {
      BookingRoute().goToCalendar(context, ref,
          dt: dt, losDays: losDays, openDrawer: openDrawer);
    });
  }

  ClickFunction onUnitViewClick(BuildContext context, WidgetRef ref,
      {bool openDrawer = false}) {
    return ClickFunction('book unit view clicked', onClick: () {
      BookingRoute().goToCalendar(context, ref, openDrawer: openDrawer);
    });
  }

  ClickFunction setUnavailabelDaysClick() {
    return ClickFunction('set unavailable days clicked', onClick: () {});
  }

  ClickFunction setLosClick() {
    return ClickFunction('set LOS clicked', onClick: () {});
  }
}
