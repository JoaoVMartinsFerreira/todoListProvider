import 'package:flutter/material.dart';
import 'package:todolist_app/shared/extensions/date_extension.dart';
import 'package:todolist_app/shared/models/todo_model.dart';
import 'package:todolist_app/shared/widgets/texts/text_widget.dart';

class TodoDateWidget extends StatelessWidget {
  final TodoModel todo;
  const TodoDateWidget(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 12),
        child: TextWidget(todo.date.formartDate));
  }
}
