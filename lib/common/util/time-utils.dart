class TimeUtils {
  String chatTime(int time1) {
    var date = DateTime.fromMillisecondsSinceEpoch(time1 * 1000);
    return date.toLocal().toString().substring(0, 16);
  }
}