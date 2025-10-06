import 'package:flutter/material.dart';

/// OptionTile now supports correctness states to show immediate feedback.
class OptionTile extends StatelessWidget {
  final String text;
  final bool selected;
  final bool isCorrect; // whether this option is the correct answer
  final bool isIncorrect; // whether this option was chosen but is wrong
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.text,
    required this.onTap,
    this.selected = false,
    this.isCorrect = false,
    this.isIncorrect = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color borderColor = Colors.grey.shade300;
    Color bgColor = Colors.white;
    Widget? trailing;

    if (isCorrect) {
      borderColor = Colors.green.shade700;
      bgColor = Colors.green.shade50;
      trailing = Icon(Icons.check_circle, color: Colors.green.shade700);
    } else if (isIncorrect) {
      borderColor = Colors.red.shade700;
      bgColor = Colors.red.shade50;
      trailing = Icon(Icons.cancel, color: Colors.red.shade700);
    } else if (selected) {
      borderColor = theme.colorScheme.primary;
      bgColor = theme.colorScheme.primary.withOpacity(0.12);
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: (selected || isCorrect || isIncorrect) ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCorrect
                    ? Colors.green.shade700
                    : (isIncorrect
                          ? Colors.red.shade700
                          : (selected
                                ? theme.colorScheme.primary
                                : Colors.transparent)),
                border: Border.all(
                  color: (selected || isCorrect || isIncorrect)
                      ? borderColor
                      : Colors.grey.shade400,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 16, color: Colors.grey[900]),
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }
}
