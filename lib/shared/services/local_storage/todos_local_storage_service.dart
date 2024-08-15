import 'dart:convert';
import 'dart:developer';

import 'package:todolist_app/shared/const/messages_const.dart';
import 'package:todolist_app/shared/errors/local_storage_exceptions.dart';
import 'package:todolist_app/shared/models/todo_model.dart';
import 'package:todolist_app/shared/services/local_storage/local_storage_service.dart';

class TodosLocalStorageService {
  final String todosKey = 'todos';
  final doneTodosKey=  'doneTodosKey';
  final LocalStorageService _localStorageService;

  TodosLocalStorageService(this._localStorageService); // Injeção de dependência

  Future<String?> setTodos(List<TodoModel> todos) async {
    try {
      final String data =
          jsonEncode(todos.map((todo) => todo.toMap()).toList());

      await _localStorageService.set(todosKey, data);

      return null;
    } on LocalStorageException {
      return "Erro ao salvar taferas.";
    } catch (error, st) {
      log('Error saving todos', error: error, stackTrace: st);
      return defaultErrorMessage;
    }
  }

  Future<(String? error, List<TodoModel>? todos)> getTodos() async {
    try {
      final String? todosJson = await _localStorageService.get(todosKey);
      if (todosJson != null) {
        final todos = (jsonDecode(todosJson) as List)
            .map<TodoModel>(
              (todo) => TodoModel.fromMap(todo),
            )
            .toList();
        return (null,todos); // o lado direito do return é null por que não retorna erro
      }

      return(null,<TodoModel>[]);

    } on LocalStorageException {
      return ("Erro ao carregar taferas.", null);
    } catch (error, st) {
      log('Error loading todos', error: error, stackTrace: st);
      return (defaultErrorMessage, null);
    }
  }

  Future<String?> setDoneTodos(List<String> doneTodos) async {
    try {
      final String data = jsonEncode(doneTodos);

      await _localStorageService.set(doneTodosKey, data);

      return null;
    } on LocalStorageException {
      return "Erro ao salvar taferas feitas.";
    } catch (error, st) {
      log('Error saving done todos', error: error, stackTrace: st);
      return defaultErrorMessage;
    }
  }

  Future<(String? error, List<String>? doneTodos)> getDoneTodos() async {
    try {
      final String? doneTodosJson = await _localStorageService.get(doneTodosKey);
      if (doneTodosJson != null) {
        final doneTodos = (jsonDecode(doneTodosJson) as List).cast<String>(); // para dizer que que é  uma lista de String
        return (null,doneTodos); // o lado direito do return é null por que não retorna erro
      }

      return(null,<String>[]);

    } on LocalStorageException {
      return ("Erro ao carregar taferas feitas.", null);
    } catch (error, st) {
      log('Error loading done todos', error: error, stackTrace: st);
      return (defaultErrorMessage, null);
    }
  }
}
