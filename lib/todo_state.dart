import 'package:flutter/foundation.dart';
import 'task.dart';
import 'todo_repository.dart';

enum Filter { all, active, done }

class TodoState extends ChangeNotifier {
  final TodoRepository repo;
  TodoState(this.repo);

  Filter filter = Filter.all;
  String query = '';

  // список с учётом фильтра и поиска
  List<Task> get list {
    String q = query.trim().toLowerCase();
    List<Task> res = [];
    for (Task t in repo.getAll()) {
      if (filter == Filter.active && t.done) continue;
      if (filter == Filter.done && !t.done) continue;
      if (!t.title.toLowerCase().contains(q)) continue;
      res.add(t);
    }
    return res;
  }

  void setFilter(Filter f) {
    filter = f;
    notifyListeners();
  }

  void setQuery(String q) {
    query = q;
    notifyListeners();
  }

  void save(Task t) {
    if (t.id == 0) {
      repo.add(t);
    } else {
      repo.update(t);
    }
    notifyListeners();
  }

  void toggle(Task t) {
    t.done = !t.done;
    repo.update(t);
    notifyListeners();
  }

  void remove(Task t) {
    repo.remove(t.id);
    notifyListeners();
  }
}
