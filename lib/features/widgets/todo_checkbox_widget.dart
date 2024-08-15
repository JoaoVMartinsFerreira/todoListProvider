import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_app/features/todos/controllers/todos_controller.dart';
import 'package:todolist_app/shared/models/todo_model.dart';

class TodoCheckboxWidget extends StatelessWidget {
  final TodoModel todo;
  const TodoCheckboxWidget(this.todo,{super.key});
  @override
  Widget build(BuildContext context) {
    final todosCtrl = context.watch<TodosController>(); // obervar as alterações da instância que no case é todosCtrl
    return Checkbox(
      value: todosCtrl.isTodoChecked(todo.id), 
      onChanged: (bool? isDone) => todosCtrl.checkTodo(todo.id),
    );
  }
}