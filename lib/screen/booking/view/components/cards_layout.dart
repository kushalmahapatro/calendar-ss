import 'package:stella_stays/screen/booking/entity/booking_state_model.dart';
import 'package:stella_stays/screen/booking/interactor/booking_interactor.dart';
import 'package:stella_stays/stella_stays.dart';
import 'package:stella_stays_gql/model.dart';

Widget unitViewCard(
    BookingStateModel changes, BuildContext context, WidgetRef ref,
    {bool openDrawer = false}) {
  return Expanded(
    child: Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: Center(
        child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              "Book unit viewing".text.bodyLarge().make(),
              "Start date: ${changes.startDateUnit}".text.make(),
              "End date: ${changes.endDateUnit}".text.make(),
            ])).paddingAll(15),
      ).circularBorder,
    ).onClick(BookingInteractor()
        .onUnitViewClick(context, ref, openDrawer: openDrawer)),
  );
}

Widget staycard(BookingStateModel changes, List<DateTime> dt, List<Day> losDays,
    BuildContext context, WidgetRef ref,
    {bool openDrawer = false}) {
  return Expanded(
    child: Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: Center(
        child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                "Book your stay".text.bodyLarge().make(),
                "Start date: ${changes.startDateStay}".text.make(),
                "End date: ${changes.endDateStay}".text.make(),
              ],
            )).paddingAll(15),
      ).circularBorder,
    ).onClick(BookingInteractor()
        .onStayBookingClick(dt, losDays, context, ref, openDrawer: openDrawer)),
  );
}
