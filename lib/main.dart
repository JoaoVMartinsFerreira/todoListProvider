import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todolist_app/features/todos/controllers/todos_controller.dart';
import 'package:todolist_app/shared/services/local_storage/local_storage_service.dart';
import 'package:todolist_app/shared/services/local_storage/todos_local_storage_service.dart';

import 'features/screens/todos_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Para criar uma  instância do todoController ec onseguir recuperar de quanquer parde to app
    return ChangeNotifierProvider(
      create: (_) => TodosController(
        TodosLocalStorageService(
          LocalStorageService(),
        ),
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black,
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 20))),
        home: const TodosScreen(),
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
        supportedLocales: const [Locale('pt', 'BR')],
      ),
    );
  }
}
