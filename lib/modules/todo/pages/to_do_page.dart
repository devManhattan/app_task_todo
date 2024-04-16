import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_moura/core/system_user_notice.dart';
import 'package:todo_moura/modules/todo/pages/add_todo_page.dart';
import 'package:todo_moura/modules/todo/usecases/delete_todo/delete_todo_bloc.dart';
import 'package:todo_moura/modules/todo/usecases/list_todo/list_todo_bloc.dart';
import 'package:todo_moura/modules/todo/usecases/update_todo/update_todo_bloc.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key, required this.done});
  final bool done;
  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  bool listByDate = true;
  bool listByTaskDate = false;
  String dropDownValue = "creation_date";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listTodo();
  }

  void listTodo() {
    if (listByDate) {
      BlocProvider.of<ListTodoBloc>(context).add(ListTodoListByDateEvent(
          done: widget.done, byTaskDate: listByTaskDate));
    } else {
      BlocProvider.of<ListTodoBloc>(context)
          .add(ListTodoListByPriorityEvent(done: widget.done));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: !widget.done
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AddTodoPage(
                    todo: null,
                  );
                })).then((value) => listTodo());
              },
              child: Icon(Icons.add),
            )
          : null,
      appBar: AppBar(
        title: !widget.done ? Text("Tarefas a fazer") : Text("Tarefas feitas"),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<UpdateTodoBloc, UpdateTodoState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is UpdateTodoSuccess) {
                NoticeMenssages.showSuccessMensager(
                    "Tarefa atualizada", context);
                listTodo();
              }
              if (state is UpdateTodoError) {
                NoticeMenssages.showSuccessMensager(
                    "Erro na atualização da tarefa", context);
              }
            },
          ),
          BlocListener<DeleteTodoBloc, DeleteTodoState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is DeleteTodoSuccess) {
                NoticeMenssages.showSuccessMensager("Tarefa deletada", context);
                listTodo();
              }
              if (state is DeleteTodoError) {
                NoticeMenssages.showSuccessMensager(
                    "Erro na deleção da tarefa", context);
              }
            },
          )
        ],
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: LayoutBuilder(builder: (context, constraints) {
            return BlocBuilder<ListTodoBloc, ListTodoState>(
              builder: (context, state) {
                if (state is ListTodoSuccess) {
                  return state.todoList.isNotEmpty
                      ? Column(
                          children: [
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  isExpanded: true,
                                  value: dropDownValue,
                                  items: const [
                                    DropdownMenuItem(
                                        value: "creation_date",
                                        child: Text(
                                            "Filtrar por data de criação")),
                                    DropdownMenuItem(
                                        value: "date_task",
                                        child:
                                            Text("Filtrar por data da task")),
                                    DropdownMenuItem(
                                        value: "priority",
                                        child: Text("Filtrar por prioridade"))
                                  ],
                                  onChanged: (value) {
                                    dropDownValue = value!;

                                    if (value.contains("date")) {
                                      listByDate = true;
                                      if (value.contains("creation")) {
                                        listByTaskDate = false;
                                      } else {
                                        listByTaskDate = true;
                                      }
                                    } else {
                                      listByDate = false;
                                    }
                                    listTodo();
                                  }),
                            ),
                            for (int counterTodos = 0;
                                counterTodos < state.todoList.length;
                                counterTodos++)
                              ListTile(
                                trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<DeleteTodoBloc>(
                                                    context)
                                                .add(DeleteTodoDeleteEvent(
                                                    todo: state
                                                        .todoList[counterTodos]
                                                      ..deletedDate = DateTime
                                                              .now()
                                                          .toIso8601String()));
                                          },
                                          child: Icon(Icons.delete)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return AddTodoPage(
                                                  todo: state
                                                      .todoList[counterTodos]);
                                            })).then((value) => listTodo());
                                            ;
                                          },
                                          child: Icon(Icons.edit)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      widget.done
                                          ? GestureDetector(
                                              onTap: () {
                                                BlocProvider.of<UpdateTodoBloc>(
                                                        context)
                                                    .add(UpdateTodoUpdateEvent(
                                                        todo: state.todoList[
                                                            counterTodos]
                                                          ..done = false));
                                              },
                                              child: Icon(Icons.arrow_back))
                                          : GestureDetector(
                                              onTap: () {
                                                BlocProvider.of<UpdateTodoBloc>(
                                                        context)
                                                    .add(UpdateTodoUpdateEvent(
                                                        todo: state.todoList[
                                                            counterTodos]
                                                          ..done = true));
                                              },
                                              child: Icon(Icons.check))
                                    ]),
                                title: Text(
                                    state.todoList[counterTodos].description),
                              )
                          ],
                        )
                      : Center(
                          child: Text("Nenhuma tarefa encontrada"),
                        );
                }
                if (state is ListTodoError) {
                  return Center(
                    child: Text("Ocorreu um erro inesperado."),
                  );
                }

                return const CircularProgressIndicator();
              },
            );
          }),
        )),
      ),
    );
  }
}
