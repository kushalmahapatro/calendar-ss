class BookingQueries {
  BookingQueries._();

  static String getConditions = """
query {
	unavailable_days {
		days
	}
	los_days {
		los_day {
			day
			los
		}
	}
}

""";
}
