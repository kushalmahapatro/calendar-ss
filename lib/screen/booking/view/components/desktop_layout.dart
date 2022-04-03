import 'package:stella_stays/screen/booking/entity/booking_state_model.dart';
import 'package:stella_stays/screen/booking/interactor/booking_interactor.dart';
import 'package:stella_stays/screen/booking/presenter/booking_presenter.dart';
import 'package:stella_stays/screen/booking/view/components/cards_layout.dart';
import 'package:stella_stays/screen/calendar/view/calendar_view.dart';
import 'package:stella_stays/stella_stays.dart';
import 'package:stella_stays_gql/model.dart';

Widget desktopLayout(BookingStateModel changes, List<DateTime> dt,
    List<Day> losDays, BuildContext context, WidgetRef ref) {
  final changes = ref.watch(BookingPresenter.provider);
  return Scaffold(
    backgroundColor: SSColors.white,
    endDrawer: Container(
      color: SSColors.white,
      width: MediaQuery.of(context).size.width / 3,
      child: CalendarView(
        unavailableDays: changes.ud,
        los: changes.los,
      ),
    ),
    body: Builder(builder: (ctx) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              staycard(changes, dt, losDays, ctx, ref, openDrawer: true),
              const SizedBox(height: 12),
              unitViewCard(changes, ctx, ref, openDrawer: true)
            ],
          ),
          const Spacer(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Flexible(
          //         child: 'Set unavailable days'.ctaActive(
          //             BookingInteractor().setUnavailabelDaysClick())),
          //     const SizedBox(width: 12.0),
          //     Flexible(
          //         child:
          //             'Set LOS'.ctaActive(BookingInteractor().setLosClick())),
          //   ],
          // ),
        ],
      ).paddingAll(10);
    }),
  );
}
