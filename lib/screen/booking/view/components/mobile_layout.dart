import 'package:stella_stays/screen/booking/entity/booking_state_model.dart';
import 'package:stella_stays/screen/booking/interactor/booking_interactor.dart';
import 'package:stella_stays/screen/booking/view/components/cards_layout.dart';
import 'package:stella_stays/stella_stays.dart';
import 'package:stella_stays_gql/model.dart';

Column mobileLayout(
  BookingStateModel changes,
  List<DateTime> dt,
  List<Day> losDays,
  BuildContext context,
  WidgetRef ref,
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      staycard(changes, dt, losDays, context, ref),
      const SizedBox(height: 12),
      unitViewCard(changes, context, ref),
      const SizedBox(height: 12),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     Flexible(
      //         child: 'Set unavailable days'
      //             .ctaActive(BookingInteractor().setUnavailabelDaysClick())),
      //     const SizedBox(width: 12.0),
      //     Flexible(
      //         child: 'Set LOS'.ctaActive(BookingInteractor().setLosClick())),
      //   ],
      // ),
    ],
  );
}
