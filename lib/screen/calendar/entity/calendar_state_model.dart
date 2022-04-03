import 'package:intl/intl.dart';

class CalendarStateModel {
  CalendarStateModel({
    this.startRange,
    this.endRange,
    this.losEnd,
    this.maxLos,
  });

  DateTime? startRange;
  DateTime? endRange;
  DateTime? losEnd;
  DateTime? maxLos;

  DateFormat df = DateFormat('yyyy-MM-dd');

  String get startDate => df.format(startRange ?? DateTime.now());
  String get endDate => df.format(endRange ?? DateTime.now());

  CalendarStateModel copyWith({
    DateTime? startRange,
    DateTime? endRange,
    DateTime? losEnd,
    DateTime? maxLos,
  }) {
    return CalendarStateModel(
      startRange: startRange,
      endRange: endRange,
      losEnd: losEnd,
      maxLos: maxLos,
    );
  }
}
