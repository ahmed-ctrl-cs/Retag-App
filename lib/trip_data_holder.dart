class Trip {
  String trip_name;
  double trip_price;
  DateTime trip_time;
  String trip_pick_up;
  String trip_drop_off;
  Trip(
    this.trip_name,
    this.trip_price,
    this.trip_time,
    this.trip_pick_up,
    this.trip_drop_off,
  );
}

String GetFormatedHour(int hour) {
  if (hour == 12) {
    return "12 PM";
  } else if (hour == 0) {
    return "12 AM";
  } else if (hour < 12) {
    return "$hour AM";
  } else {
    return "${hour - 12} PM";
  }
}

//This holds the names of the months to show them in our beautifull card
final List<String> Month = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];
