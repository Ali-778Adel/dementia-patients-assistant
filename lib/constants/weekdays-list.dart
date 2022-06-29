import 'package:intl/intl.dart';

List<String> getDaysOfWeek([String? locale]) {
  final now = DateTime.now();
  final firstDayOfWeek = now;
  return List.generate(7, (index) => index)
      .map((value) => DateFormat(DateFormat.WEEKDAY, locale)
          .format(firstDayOfWeek.add(Duration(days: value))))
      .toList();
}

List<String>? _daysOfWeek;
List<String> get daysOfWeek {
  _daysOfWeek ??= getDaysOfWeek();
  return _daysOfWeek!;
}
