const List<String> months = [
  'янв', 'фев', 'мар', 'апр', 'мая', 'июн',
  'июл', 'авг', 'сен', 'окт', 'ноя', 'дек',
];

class Task {
  int id; // 0 - новая
  String title;
  bool done;
  int prio; // 0 низкий, 1 средний, 2 высокий
  DateTime created;

  Task({
    this.id = 0,
    required this.title,
    this.done = false,
    this.prio = 1,
    required this.created,
  });

  String prioName() {
    if (prio == 2) return 'Высокий';
    if (prio == 1) return 'Средний';
    return 'Низкий';
  }

  String dateStr() {
    String h = created.hour.toString().padLeft(2, '0');
    String m = created.minute.toString().padLeft(2, '0');
    return '${created.day} ${months[created.month - 1]}, $h:$m';
  }
}
