class TimeUtils {
  String chatTime(int time1) {
    if (time1 == null){
      return "";
    }
    var date = DateTime.fromMillisecondsSinceEpoch(time1 * 1000);
    return date.toLocal().toString().substring(0, 16);
  }
}