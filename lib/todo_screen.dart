import 'package:flutter/material.dart';
import 'choice_btn.dart';
import 'edit_screen.dart';
import 'task.dart';
import 'task_tile.dart';
import 'todo_state.dart';

const Color bg = Colors.black;
const Color btnColor = Color(0xFF333333);
const Color orange = Colors.orange;
const Color gray = Colors.grey;

class TodoScreen extends StatefulWidget {
  final TodoState st;
  const TodoScreen({super.key, required this.st});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TodoState get st => widget.st;

  @override
  void initState() {
    super.initState();
    st.addListener(update);
  }

  @override
  void dispose() {
    st.removeListener(update);
    super.dispose();
  }

  void update() {
    setState(() {});
  }

  // открываем форму и ждём что она вернёт
  void openForm(Task? t) async {
    var res = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditScreen(task: t)),
    );
    if (res != null) {
      st.save(res);
    }
  }

  Future<bool> askDelete(Task t) async {
    bool? ok = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: btnColor,
        title: const Text('Удалить задачу?'),
        content: Text(t.title),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Отмена', style: TextStyle(color: gray)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Удалить', style: TextStyle(color: orange)),
          ),
        ],
      ),
    );
    return ok == true;
  }

  void delete(Task t) async {
    if (await askDelete(t)) {
      st.remove(t);
    }
  }

  Widget filterBtn(String t, Filter f) {
    return Expanded(
      child: ChoiceBtn(
        text: t,
        selected: st.filter == f,
        onTap: () => st.setFilter(f),
      ),
    );
  }

  Widget listBlock() {
    List<Task> list = st.list;
    if (list.isEmpty) {
      return const Center(
        child: Text('Задач нет', style: TextStyle(fontSize: 18, color: gray)),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(24, 4, 24, 90),
      itemCount: list.length,
      itemBuilder: (context, i) {
        Task t = list[i];
        // свайп влево - удалить
        return Dismissible(
          key: ValueKey(t.id),
          direction: DismissDirection.endToStart,
          background: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.only(right: 24),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(Icons.delete, color: Colors.white, size: 30),
          ),
          confirmDismiss: (dir) => askDelete(t),
          onDismissed: (dir) => st.remove(t),
          child: TaskTile(
            task: t,
            onCheck: () => st.toggle(t),
            onEdit: () => openForm(t),
            onDelete: () => delete(t),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      floatingActionButton: FloatingActionButton(
        backgroundColor: orange,
        foregroundColor: Colors.white,
        onPressed: () => openForm(null),
        child: const Icon(Icons.add, size: 32),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Мои задачи',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  // поиск
                  TextField(
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    cursorColor: orange,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: btnColor,
                      hintText: 'Поиск задач...',
                      hintStyle: const TextStyle(color: gray),
                      prefixIcon: const Icon(Icons.search, color: gray),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: st.setQuery,
                  ),
                  const SizedBox(height: 12),
                  // фильтры
                  Row(
                    children: [
                      filterBtn('Все', Filter.all),
                      const SizedBox(width: 8),
                      filterBtn('Активные', Filter.active),
                      const SizedBox(width: 8),
                      filterBtn('Выполненные', Filter.done),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(child: listBlock()),
          ],
        ),
      ),
    );
  }
}
