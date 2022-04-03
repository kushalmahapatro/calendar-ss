import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:scrollable_clean_calendar/models/day_values_model.dart';
import 'package:scrollable_clean_calendar/utils/extensions.dart';
import 'package:stella_stays/screen/calendar/presenter/calendar_presenter.dart';
import 'package:stella_stays/stella_stays.dart';

Widget beauty(
  BuildContext context,
  DayValues values,
  WidgetRef ref, {
  bool disabled = false,
  DateTime? losEnd,
  DateTime? maxLos,
}) {
  final changes = ref.watch(CalendarPresenter.provider);

  Color disableBackgroundColor = Colors.grey;
  Color selectedBackgroundColor = SSColors.primary;
  Color selectedBackgroundColorBetween = SSColors.primary.withOpacity(0.2);
  double radius = 10;

  BorderRadiusGeometry? borderRadius;
  Color bgColor = Colors.transparent;
  TextStyle txtStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
        color: !disabled ? Colors.black : Colors.grey,
        decoration: disabled ? TextDecoration.lineThrough : null,
        fontWeight: values.isFirstDayOfWeek || values.isLastDayOfWeek
            ? FontWeight.bold
            : null,
      );

  if (changes.startRange != null &&
      values.day.isSameDayOrAfter(changes.startRange!)) {
    if ((changes.startRange != null &&
            values.day.isSameDay(changes.startRange!)) ||
        (changes.endRange != null && values.day.isSameDay(changes.endRange!))) {
      bgColor = selectedBackgroundColor;
      txtStyle = txtStyle.copyWith(
        color: selectedBackgroundColor.computeLuminance() > .5
            ? Colors.black
            : Colors.white,
        fontWeight: values.isFirstDayOfWeek || values.isLastDayOfWeek
            ? FontWeight.bold
            : null,
      );

      if (changes.startRange == changes.endRange) {
        borderRadius = BorderRadius.circular(radius);
      } else if (changes.startRange != null &&
          values.day.isSameDay(changes.startRange!)) {
        borderRadius = BorderRadius.only(
          topLeft: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
        );
      } else if (changes.endRange != null &&
          values.day.isSameDay(changes.endRange!)) {
        borderRadius = BorderRadius.only(
          topRight: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        );
      }
    } else if (changes.startRange != null &&
        values.day.isAfter(changes.startRange!)) {
      if (changes.endRange != null && values.day.isBefore(changes.endRange!)) {
        bgColor = selectedBackgroundColorBetween;
        txtStyle = txtStyle.copyWith(
          color: selectedBackgroundColor,
          fontWeight: values.isFirstDayOfWeek || values.isLastDayOfWeek
              ? FontWeight.bold
              : null,
        );
      } else if (changes.losEnd != null &&
          values.day.isBefore(changes.losEnd!)) {
        bgColor = selectedBackgroundColorBetween;
        txtStyle = txtStyle.copyWith(
          color: selectedBackgroundColor,
          fontWeight: values.isFirstDayOfWeek || values.isLastDayOfWeek
              ? FontWeight.bold
              : null,
        );
      }
    }
  } else if (values.day.isSameDay(values.minDate)) {
  } else if (values.day.isBefore(values.minDate) ||
      values.day.isAfter(values.maxDate)) {
    txtStyle = (Theme.of(context).textTheme.bodyText1)!.copyWith(
      color: disableBackgroundColor.computeLuminance() > .5
          ? Colors.black.withOpacity(.5)
          : Colors.white.withOpacity(.5),
      decoration: TextDecoration.lineThrough,
      fontWeight: values.isFirstDayOfWeek || values.isLastDayOfWeek
          ? FontWeight.bold
          : null,
    );
  }
  if (losEnd != null && changes.startRange != null) {
    if (values.day.isAfter(changes.startRange!) &&
        values.day.isSameDayOrBefore(losEnd)) {
      Color textColor = Colors.white;
      if (changes.endRange != null && values.day == changes.endRange) {
        bgColor = selectedBackgroundColor;
        textColor = Colors.white;
      } else {
        bgColor = selectedBackgroundColorBetween;
        textColor = selectedBackgroundColor;
      }
      txtStyle = txtStyle.copyWith(
        color: textColor,
        decoration:
            changes.endRange == null ? TextDecoration.lineThrough : null,
        fontWeight: values.isFirstDayOfWeek || values.isLastDayOfWeek
            ? FontWeight.bold
            : null,
      );
    } else if (values.day.isBefore(changes.startRange!)) {
      if (changes.endRange == null) {
        txtStyle = txtStyle.copyWith(
          color: disableBackgroundColor,
          decoration: TextDecoration.lineThrough,
          fontWeight: values.isFirstDayOfWeek || values.isLastDayOfWeek
              ? FontWeight.bold
              : null,
        );
      }
    } else if (maxLos != null &&
        changes.endRange == null &&
        values.day.isSameDayOrAfter(maxLos)) {
      txtStyle = txtStyle.copyWith(
        color: disableBackgroundColor,
        decoration: TextDecoration.lineThrough,
        fontWeight: values.isFirstDayOfWeek || values.isLastDayOfWeek
            ? FontWeight.bold
            : null,
      );
    }
  }

  if (values.day.isSameDayOrAfter(values.minDate) &&
      values.day.isSameDayOrBefore(values.maxDate)) {
    if (values.day == changes.startRange && changes.endRange == null) {
      JustTheController con = JustTheController();
      Future.delayed(const Duration(milliseconds: 500), () {
        try {
          if ((losEnd?.difference(values.day).inDays ?? 0) > 0) {
            con.showTooltip();
          }
        } on Exception catch (_) {}
      });
      int diff = losEnd?.difference(values.day).inDays ?? 0;
      return JustTheTooltip(
          barrierDismissible: false,
          tailLength: 5,
          tailBaseWidth: 5,
          triggerMode: TooltipTriggerMode.manual,
          controller: con,
          content: Container(
            margin: const EdgeInsets.all(4),
            child: Text(
              "Minimum ${diff > 1 ? '$diff days' : '$diff day'} stay",
              style: TextStyle(color: selectedBackgroundColor, fontSize: 9),
            ),
          ),
          child: DayWidget(
            bgColor: bgColor,
            borderRadius: borderRadius,
            txtStyle: txtStyle,
            text: values.text,
          ));
    } else {
      return DayWidget(
          bgColor: bgColor,
          borderRadius: borderRadius,
          txtStyle: txtStyle,
          text: values.text);
    }
  } else {
    return Container();
  }
}

class DayWidget extends StatelessWidget {
  const DayWidget({
    Key? key,
    required this.bgColor,
    required this.borderRadius,
    required this.txtStyle,
    required this.text,
  }) : super(key: key);

  final Color bgColor;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle txtStyle;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: txtStyle,
      ),
    );
  }
}
