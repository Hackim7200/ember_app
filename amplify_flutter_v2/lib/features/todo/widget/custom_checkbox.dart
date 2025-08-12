import 'package:flutter/material.dart';

Widget customCheckbox(BuildContext context, bool isChecked) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    width: 24,
    height: 24,
    decoration: BoxDecoration(
      color: isChecked ? Theme.of(context).primaryColor : Colors.transparent,
      border: Border.all(
        color: isChecked ? Theme.of(context).primaryColor : Colors.grey[400]!,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(4),
    ),
    child: isChecked
        ? const Icon(Icons.check, size: 16, color: Colors.white)
        : null,
  );
}
