class StringUtil {
  static String capitalize(String string) =>
      string.isEmpty ? string : string[0].toUpperCase() + string.substring(1);

  static List<String> formatTimeArray(List<int> times) {
    if (times.isEmpty) return [];
    if (times.length >= 24) return ["All day"];

    List<String> result = [];
    var from = times[0];
    var to = times[0];

    for (int index = 1; index <= times.length; index++) {
      if (index >= times.length) {
        result.add("$from:00~$to:59");
        break;
      }

      int month = times[index];
      if (to + 1 == month) {
        to = month;
        continue;
      }

      result.add("$from:00~$to:59");
      from = month;
      to = month;
    }
    return result;
  }

  static List<String> formatMonthArray(List<int> months) {
    if (months.isEmpty) return [];
    if (months.length >= 12) return ["All year"];

    List<String> result = [];
    var from = months[0];
    var to = months[0];

    for (int index = 1; index <= months.length; index++) {
      if (index >= months.length) {
        if (from == to)
          result.add(_monthToString(from));
        else
          result.add("${_monthToString(from)}~${_monthToString(to)}");
        break;
      }

      int month = months[index];
      if (to + 1 == month) {
        to = month;
        continue;
      }

      if (from == to)
        result.add(_monthToString(from));
      else
        result.add("${_monthToString(from)}~${_monthToString(to)}");

      from = month;
      to = month;
    }
    return result;
  }

  static List<String> _monthNames = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  static String _monthToString(int month) => _monthNames[month - 1];
}
