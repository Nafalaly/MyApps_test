part of 'shared.dart';

Future<bool> hasNetwork() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

String dateFormat(DateTime time) {
  return '${DateFormat.d('en_US').format(time)} ${DateFormat.MMMM('en_US').format(time)} ${DateFormat.y('en_US').format(time)} ${DateFormat.Hms('en_US').format(time)}';
}
