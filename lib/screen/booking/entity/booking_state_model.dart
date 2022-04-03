import 'package:stella_stays_gql/model.dart';

class BookingStateModel {
  BookingStateModel({
    this.startDateStay = '',
    this.endDateStay = '',
    this.startDateUnit = '',
    this.endDateUnit = '',
    this.los,
    this.ud,
  });

  final String startDateStay;
  final String endDateStay;
  final String startDateUnit;
  final String endDateUnit;
  final List<DateTime>? ud;
  final List<Day>? los;

  DateTime get startDateStayDT => DateTime.parse(startDateStay);
  DateTime get endDateStayDT => DateTime.parse(endDateStay);
  DateTime get startDateUnitDT => DateTime.parse(startDateUnit);
  DateTime get endDateUnitDT => DateTime.parse(endDateUnit);

  BookingStateModel copyWith({
    String? startDateStay,
    String? endDateStay,
    String? startDateUnit,
    String? endDateUnit,
    List<DateTime>? ud,
    List<Day>? los,
  }) {
    return BookingStateModel(
      startDateStay: startDateStay ?? this.startDateStay,
      endDateStay: endDateStay ?? this.endDateStay,
      startDateUnit: startDateUnit ?? this.startDateUnit,
      endDateUnit: endDateUnit ?? this.endDateUnit,
      ud: ud,
      los: los,
    );
  }
}
