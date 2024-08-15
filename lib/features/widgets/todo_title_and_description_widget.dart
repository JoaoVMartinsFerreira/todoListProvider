import 'package:flutter/material.dart';
import 'package:todolist_app/shared/models/todo_model.dart';
import 'package:todolist_app/shared/widgets/texts/text_widget.dart';

class TodoTitleAndDescriptionWidget extends StatelessWidget {
  final TodoModel todo;
  const TodoTitleAndDescriptionWidget(this.todo,{super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(todo.title, cfontSize: 20,),
          if(todo.description != null) 
          TextWidget(todo.description!, cfontSize: 16,)
        ],
      ),
    );
  }
}