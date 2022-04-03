import 'package:responsive_builder/responsive_builder.dart';
import 'package:stella_stays/screen/booking/presenter/booking_presenter.dart';
import 'package:stella_stays/screen/booking/presenter/booking_queries.dart';
import 'package:stella_stays/screen/booking/view/components/desktop_layout.dart';
import 'package:stella_stays/screen/booking/view/components/mobile_layout.dart';
import 'package:stella_stays/stella_stays.dart';
import 'package:stella_stays_gql/model.dart';

class BookingView extends HookConsumerWidget {
  const BookingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final changes = ref.watch(BookingPresenter.provider);

    return Scaffold(
      appBar: AppBar(
        title: 'Stella Stays'.text.bodyLarge(color: Colors.white).make(),
      ),
      body: Query(
        options: QueryOptions(document: gql(BookingQueries.getConditions)),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return circularProgress();
          }

          List<DateTime> dt = (result.data!['unavailable_days'][0]['days'])
              .map((s) => DateTime.parse(s.toString()))
              .toList()
              .cast<DateTime>();

          List<Day> losDays = (result.data!['los_days'][0]['los_day'])
              .map((dynamic s) {
                return Day(day: s['day'].toString(), los: s['los'].toString());
              })
              .toList()
              .cast<Day>();

          return SafeArea(
            child: ScreenTypeLayout(
              mobile: mobileLayout(changes, dt, losDays, context, ref)
                  .paddingAll(10),
              desktop: desktopLayout(changes, dt, losDays, context, ref),
              tablet: desktopLayout(changes, dt, losDays, context, ref),
            ),
          );
        },
      ),
    );
  }
}
