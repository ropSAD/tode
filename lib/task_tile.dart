import 'package:flutter/material.dart';
import 'task.dart';

Color prioColor(int p) {
  if (p == 2) return Colors.redAccent;
  if (p == 1) return Colors.orange;
  return Colors.green;
}

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onCheck;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const TaskTile({
    super.key,
    required this.task,
    required this.onCheck,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    Color c = prioColor(task.prio);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: const Color(0xFF333333),
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onEdit,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Checkbox(
                  value: task.done,
                  activeColor: Colors.orange,
                  onChanged: (v) => onCheck(),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // выполненную зачёркиваем
                      Text(
                        task.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          color: task.done ? Colors.grey : Colors.white,
                          decoration:
                              task.done ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        task.dateStr(),
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: c),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    task.prioName(),
                    style: TextStyle(fontSize: 13, color: c),
                  ),
                ),
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert, color: Colors.grey),
                  color: const Color(0xFF333333),
                  onSelected: (v) {
                    if (v == 'edit') {
                      onEdit();
                    } else {
                      onDelete();
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: 'edit', child: Text('Изменить')),
                    PopupMenuItem(value: 'del', child: Text('Удалить')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
