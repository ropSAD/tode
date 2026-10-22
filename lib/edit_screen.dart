import 'package:flutter/material.dart';
import 'choice_btn.dart';
import 'task.dart';
import 'task_tile.dart';

class EditScreen extends StatefulWidget {
  final Task? task; // null если новая
  const EditScreen({super.key, this.task});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleCtrl = TextEditingController();
  int prio = 1;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleCtrl.text = widget.task!.title;
      prio = widget.task!.prio;
    }
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    super.dispose();
  }

  void save() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    Task t;
    if (widget.task == null) {
      t = Task(title: titleCtrl.text.trim(), prio: prio, created: DateTime.now());
    } else {
      t = widget.task!;
      t.title = titleCtrl.text.trim();
      t.prio = prio;
    }
    Navigator.pop(context, t);
  }

  Widget label(String t) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 16, 0, 8),
      child: Text(t, style: const TextStyle(fontSize: 18, color: Colors.grey)),
    );
  }

  Widget prioBtn(String t, int p) {
    return Expanded(
      child: ChoiceBtn(
        text: t,
        selected: prio == p,
        color: prioColor(p),
        onTap: () {
          setState(() {
            prio = p;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.task == null ? 'Новая задача' : 'Редактирование'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                label('Название'),
                TextFormField(
                  controller: titleCtrl,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                  cursorColor: Colors.orange,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF333333),
                    hintText: 'Что нужно сделать?',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Введите название задачи';
                    }
                    return null;
                  },
                ),
                label('Приоритет'),
                Row(
                  children: [
                    prioBtn('Низкий', 0),
                    const SizedBox(width: 8),
                    prioBtn('Средний', 1),
                    const SizedBox(width: 8),
                    prioBtn('Высокий', 2),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 64,
                  child: Material(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(18),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: save,
                      child: const Center(
                        child: Text(
                          'Сохранить',
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
