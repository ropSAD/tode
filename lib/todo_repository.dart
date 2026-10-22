import 'task.dart';

// храним в памяти, после перезапуска всё пропадёт
class TodoRepository {
  List<Task> tasks = [];
  int lastId = 0;

  List<Task> getAll() {
    return tasks;
  }

  void add(Task t) {
    lastId++;
    t.id = lastId;
    tasks.insert(0, t);
  }

  void update(Task t) {
    int i = tasks.indexWhere((x) => x.id == t.id);
    if (i != -1) {
      tasks[i] = t;
    }
  }

  void remove(int id) {
    tasks.removeWhere((x) => x.id == id);
  }
}
