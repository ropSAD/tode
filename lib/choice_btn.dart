import 'package:flutter/material.dart';

// кнопка для фильтров и приоритета
class ChoiceBtn extends StatelessWidget {
  final String text;
  final bool selected;
  final Color color;
  final VoidCallback onTap;
  const ChoiceBtn({
    super.key,
    required this.text,
    required this.selected,
    required this.onTap,
    this.color = Colors.orange,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? color : const Color(0xFF333333),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: SizedBox(
          height: 48,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
