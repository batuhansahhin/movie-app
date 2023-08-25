import 'package:easy_localization/easy_localization.dart';

String formatRuntime(int? runtime) {
  if (runtime == null) return '';

  int hours = runtime ~/ 60;
  int minutes = runtime % 60;

  String formattedTime = '$hours hr $minutes min';
  return formattedTime;
}

String formatReleaseDate(String? releaseDate) {
  try {
    var dateTime = DateTime.parse(releaseDate!);
    String formattedDate = '${dateTime.year}';
    return formattedDate;
  } catch (e) {
    return tr('unknow_date');
  }
}
