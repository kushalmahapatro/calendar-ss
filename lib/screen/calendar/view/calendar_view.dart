import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';
import 'package:scrollable_clean_calendar/utils/extensions.dart';
import 'package:stella_stays/screen/calendar/entity/calendar_state_model.dart';
import 'package:stella_stays/screen/calendar/interactor/calendar_interactor.dart';
import 'package:stella_stays/screen/calendar/presenter/calendar_presenter.dart';
import 'package:stella_stays/screen/calendar/view/components/date_widget.dart';
import 'package:stella_stays/stella_stays.dart';

import 'package:stella_stays_gql/model.dart';

// ignore: must_be_immutable
class CalendarView extends HookConsumerWidget {
  CalendarView({this.unavailableDays, this.los, Key? key}) : super(key: key);

  final List<DateTime>? unavailableDays;
  final List<Day>? los;

  CleanCalendarController? _controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final changes = ref.watch(CalendarPresenter.provider);
    return WillPopScope(
      onWillPop: () async {
        ref.read(CalendarPresenter.provider.notifier).reset();
        if (_controller != null) _controller!.clearSelectedDates();

        return true;
      },
      child: Column(
        children: [
          /// App bar
          AppBar(
            title: const Text('Calendar'),
            automaticallyImplyLeading: false,
            actions: [
              const Icon(Icons.close).paddingSymmetric(horizontal: 4).onClick(
                  CalendarInteractor().cancelClick(ref, _controller, context))
            ],
          ),

          /// Calendar widget
          Expanded(
            child: ScrollableCleanCalendar(
              dayBuilder: ((context, val) {
                return beauty(
                  context,
                  val,
                  ref,
                  disabled: unavailableDays != null
                      ? unavailableDays!
                          .contains(DateTime.parse(changes.df.format(val.day)))
                      : false,
                  losEnd: changes.losEnd,
                  maxLos: changes.maxLos,
                );
              }),
              calendarController:
                  getController(changes, ref, los, unavailableDays),
              layout: Layout.BEAUTY,
              calendarCrossAxisSpacing: 0,
            ),
          ),

          /// Bottom widget
          Visibility(
            visible: changes.startRange != null || changes.endRange != null,
            child: SafeArea(
              child: Column(
                children: [
                  const Divider(
                    height: 1,
                    color: SSColors.primary,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      "Clear".text.bodySmall().make().onClick(
                          CalendarInteractor()
                              .onClearClick(ref, _controller, context)),
                      const Spacer(),
                      Flexible(
                          flex: 1,
                          child: "Apply".ctaActive(
                              CalendarInteractor().onApplyClick(
                                  changes, ref, context,
                                  isCondition:
                                      unavailableDays != null && los != null),
                              disable: !(changes.startRange != null &&
                                  changes.endRange != null)))
                    ],
                  ).paddingAll(12),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  getController(CalendarStateModel changes, WidgetRef ref, List<Day>? losDays,
      List<DateTime>? dt) {
    _controller = CleanCalendarController(
      rangeMode: true,
      minDate: DateTime.now(),
      maxDate: DateTime.now().add(const Duration(days: 365)),
      onRangeSelected: (start, end) {
        if (dt == null && losDays == null) {
          if (changes.startRange != null &&
              start.isBefore(changes.startRange!)) {
            ref.read(CalendarPresenter.provider.notifier)
              ..updateStartDate(start)
              ..updateEndDate(null);
          } else {
            ref.read(CalendarPresenter.provider.notifier)
              ..updateStartDate(start)
              ..updateEndDate(end);
          }
        }
      },
      onDayTapped: (DateTime date) {
        if (dt != null && losDays != null) {
          if (!dt.contains(DateTime.parse(changes.df.format(date)))) {
            if (changes.startRange != null && changes.endRange != null) {
              CalendarPresenter.updateInitialSelection(
                  losDays, date, changes, dt, ref);
            } else if (changes.startRange == null) {
              CalendarPresenter.updateInitialSelection(
                  losDays, date, changes, dt, ref);
            } else if (changes.endRange == null &&
                changes.startRange != null &&
                date.isAfter(changes.startRange!)) {
              if (changes.maxLos != null &&
                  date.isSameDayOrBefore(changes.maxLos!) &&
                  changes.losEnd != null &&
                  date.isSameDayOrAfter(changes.losEnd!)) {
                ref
                    .read(CalendarPresenter.provider.notifier)
                    .updateEndDate(date);

                return;
              } else if (changes.maxLos == null) {
                if (changes.losEnd != null &&
                    date.isSameDayOrAfter(changes.losEnd!)) {
                  ref
                      .read(CalendarPresenter.provider.notifier)
                      .updateEndDate(date);
                  return;
                }
              }
            }
          }
        }
      },
      weekdayStart: DateTime.monday,
      initialDateSelected: changes.startRange,
      endDateSelected: changes.endRange,
    );

    return _controller;
  }
}
