import 'package:flutter/material.dart';

class AddTodoIconWidget extends StatelessWidget {
  final void Function() goToAddTodoScreen;
  const AddTodoIconWidget({required this.goToAddTodoScreen, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: goToAddTodoScreen,
      icon: const Icon(
        Icons.add,
        color: Colors.white,
        size: 35,
      ),
    );
  }
}
