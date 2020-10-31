String capitalize(String string) =>
    string.isEmpty ? string : string[0].toUpperCase() + string.substring(1);

List<String> months = [
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

String monthToString(int month) => months[month - 1];

List<String> formatMonthList(List<int> months) {
  if (months.isEmpty) return [];
  if (months.length >= 12) return ["All year"];

  List<String> result = [];
  var from = months[0];
  var to = months[0];

  for (int index = 1; index <= months.length; index++) {
    if (index >= months.length) {
      if (from == to)
        result.add(monthToString(from));
      else
        result.add("${monthToString(from)}~${monthToString(to)}");
      break;
    }

    int month = months[index];
    if (to + 1 == month) {
      to = month;
      continue;
    }

    if (from == to)
      result.add(monthToString(from));
    else
      result.add("${monthToString(from)}~${monthToString(to)}");

    from = month;
    to = month;
  }
  return result;
}
