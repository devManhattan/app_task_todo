import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_moura/modules/todo/pages/container_page.dart';
import 'package:todo_moura/modules/todo/repository/reposiotry.dart';
import 'package:todo_moura/modules/todo/repository/repository_interface.dart';
import 'package:todo_moura/modules/todo/usecases/create_todo/create_todo_bloc.dart';
import 'package:todo_moura/modules/todo/usecases/delete_todo/delete_todo_bloc.dart';
import 'package:todo_moura/modules/todo/usecases/list_todo/list_todo_bloc.dart';
import 'package:todo_moura/modules/todo/usecases/update_todo/update_todo_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.instance.registerSingleton<ITodoRepository>(TodoRepository());
  await initializeTodoRepository();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => CreateTodoBloc(),
      ),
      BlocProvider(
        create: (context) => DeleteTodoBloc(),
      ),
      BlocProvider(
        create: (context) => UpdateTodoBloc(),
      ),
      BlocProvider(
        create: (context) => ListTodoBloc(),
      ),
    ],
    child: MaterialApp(
      locale: const Locale('pt', 'BR'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),
      ],
      home: const ContainerPage(),
      theme: ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.lightBlue[900],
            foregroundColor: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            return Colors.lightBlue[900];
          }),
          foregroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            return Colors.white;
          }),
          textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (Set<MaterialState> states) {
            return TextStyle(color: Colors.white);
          }),
          minimumSize: MaterialStateProperty.resolveWith<Size?>(
              (Set<MaterialState> states) {
            return Size(double.infinity, 40);
          }),
        )),
        inputDecorationTheme: InputDecorationTheme(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white),
          centerTitle: true,
          color: Colors.lightBlue[900],
        ),
        primaryColor: Colors.lightBlue[900],
      ),
    ),
  ));
}

Future<void> initializeTodoRepository() async {
  await GetIt.instance.get<ITodoRepository>().init();
}
