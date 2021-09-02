import 'package:timezone/timezone.dart' as tz;

DateTime getToday() {
  var time = DateTime.now();
  var mexicoCity = tz.getLocation('America/Mexico_City');
  return tz.TZDateTime.from(time, mexicoCity);
}
