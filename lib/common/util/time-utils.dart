class TimeUtils {
  String chatTime(int time1) {
    var date = DateTime.fromMicrosecondsSinceEpoch(time1 * 1000*1000);
    return date.toLocal().toString().substring(0, 16);
  }
}