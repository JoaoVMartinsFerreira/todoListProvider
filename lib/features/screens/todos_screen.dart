import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_app/features/add_todo/screens/add_todo_screen.dart';
import 'package:todolist_app/features/todos/controllers/todos_controller.dart';
import 'package:todolist_app/features/widgets/todo_title_and_description_widget.dart';
import 'package:todolist_app/shared/models/todo_model.dart';
import 'package:todolist_app/shared/widgets/texts/text_widget.dart';
import '../widgets/add_todo_icon_widget.dart';
import '../widgets/loading_error_widget.dart';
import '../widgets/todo_checkbox_widget.dart';
import '../widgets/todo_date_widget.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    // Vai carregar as taferas feitas e não feitas.
    //Só vai ser invocada quando tivermos o contexto, apenas para ler
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadTodoAndDoneTodos();
    });
    super.initState();
  }

  Future<void> loadTodoAndDoneTodos() async {
    isLoading = true;
    error = null;

    final todosCtrl = context.read<TodosController>();
    final String? errorLoadingTodos = await todosCtrl.loadTodos();
    if (context.mounted) {
      final String? errorLoadingDoneTodos = await todosCtrl.loadDoneTodos();

      if (errorLoadingTodos != null || errorLoadingDoneTodos != null) {
        setState(() {
          error = errorLoadingTodos ?? errorLoadingDoneTodos;
        });
      }
      setState(() {
        // Parou de carregar
        isLoading = false;
      });
    }
  }

  void _goToAddTodoScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const AddTodoScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Recupera a instância e consegue ler ela.
    //Serve para assistir as alterações quando clicar no checkbox ou outra tarefa for adicionada
    final todosCtrl = context.watch<TodosController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List - Provider'),
        actions: [
          AddTodoIconWidget(
            goToAddTodoScreen: _goToAddTodoScreen,
          ),
        ],
      ),
      body: isLoading || error != null
          ? LoadingErrorWidget(
              isLoading: isLoading,
              error: error,
              loadTodosAndDneTodos: loadTodoAndDoneTodos,
            )
          : todosCtrl.todos.isEmpty
              ? const Center(
                  child: TextWidget('Você ainda não possui nenhuma tarefa.'),
                )
              : ListView.builder(
                  itemCount: todosCtrl.todos.length,
                  itemBuilder: (_, int index) {
                    final TodoModel todo = todosCtrl.todos[index];
                    return Row(
                      children: [
                        TodoCheckboxWidget(todo),
                        const SizedBox(width: 12),
                        TodoTitleAndDescriptionWidget(todo),
                        TodoDateWidget(todo),
                      ],
                    );
                  }),
    );
  }
}
