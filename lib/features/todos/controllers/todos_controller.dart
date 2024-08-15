import 'package:flutter/material.dart';
import 'package:todolist_app/shared/models/todo_model.dart';
import 'package:todolist_app/shared/services/local_storage/todos_local_storage_service.dart';
///Usar a injeção de dependência do TodosLocalStorage 
///service por que  sempe que temos 
///depedências de uma classe não vale a pena instnaciar dentro da 
///  classe por que assim não é possível fazer testes unitários
  
class TodosController extends ChangeNotifier{ 
 
  final TodosLocalStorageService _todosLocalStorageService; // A variável é uma do TodosController

  TodosController(this._todosLocalStorageService); // Ijeção

  final  List<TodoModel>todos = [];

  final List<String> doneTodos = [];

  Future<String?> loadTodos() async{
    final(String? error, List<TodoModel>? loadedTodos) = 
      await _todosLocalStorageService.getTodos();

      if(error == null){
        todos..clear()..addAll(loadedTodos!);
        
        sortTodosByDate();
      }
      return error;
  }

  void sortTodosByDate() {
    todos.sort((todoA, todoB) => todoA.date.compareTo(todoB.date));
    notifyListeners();
  }
  Future<String?> loadDoneTodos() async {
    final(String? error, List<String>?  loadDoneTodos) = 
      await _todosLocalStorageService.getDoneTodos();

      if (error == null) {
        doneTodos..clear()..addAll(loadDoneTodos!);
      }
      return error;
  }

  Future<String?> addTodo(TodoModel todo) async {
    todos.add(todo);

    final String? error = await saveTodos();

    if(error  == null){
      sortTodosByDate();
    }
    return error;
  }

  Future<String?> saveTodos() {
    return _todosLocalStorageService.setTodos(todos);
  }

  bool isTodoChecked(String id){
    //Iteração para  verificar se o item de doneTodos é  igual ao id;
    return doneTodos.indexWhere((checkedTodoId) => checkedTodoId == id) != -1;
  }

  Future<String?> checkTodo(String id) async {
    if(!isTodoChecked(id)){
      doneTodos.add(id);
    }else{
      doneTodos.removeWhere((checkedTodoId) => checkedTodoId == id);
    }
    final String ? error = await _todosLocalStorageService.setDoneTodos(doneTodos);

    if (error == null) {
      notifyListeners();
    }
    // Deu erro
    if(isTodoChecked(id)){
      doneTodos.add(id);
    }else{
      doneTodos.removeWhere((checkedTodoId) => checkedTodoId == id);
    }
    return error;
  }
}