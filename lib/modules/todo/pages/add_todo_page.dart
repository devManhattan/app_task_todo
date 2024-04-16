import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_moura/core/brasil_date_format.dart';
import 'package:todo_moura/core/system_user_notice.dart';
import 'package:todo_moura/modules/todo/models/todo.dart';
import 'package:todo_moura/modules/todo/usecases/create_todo/create_todo_bloc.dart';
import 'package:todo_moura/modules/todo/usecases/update_todo/update_todo_bloc.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key, required this.todo});
  final Todo? todo;
  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  bool highPriority = false;
  TextEditingController description = TextEditingController();
  DateTime? dateTimeTask;
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.todo != null) {
      highPriority = widget.todo!.priority == 1;
      description.text = widget.todo!.description;
      dateTimeTask = DateTime.parse(widget.todo!.taskDate);
      date.text =
          BrasilDateFormat().formatDate(DateTime.parse(widget.todo!.taskDate));
      time.text =
          BrasilDateFormat().formatTime(DateTime.parse(widget.todo!.taskDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar tarefa"),
      ),
      body: BlocListener<CreateTodoBloc, CreateTodoState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is CreateTodoSuccess) {
            NoticeMenssages.showSuccessMensager("Tarefa criada", context);
          }
          if (state is CreateTodoError) {
            NoticeMenssages.showSuccessMensager(
                "Erro na criação da tarefa", context);
          }
        },
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocBuilder<CreateTodoBloc, CreateTodoState>(
            builder: (context, state) {
              if (state is CreateTodoLoading) {
                return const CircularProgressIndicator();
              }
              return LayoutBuilder(builder: (context, constraints) {
                return Column(
                  children: [
                    TextField(
                      controller: description,
                      decoration: InputDecoration(hintText: "Descrição"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.4,
                          child: TextField(
                            keyboardType: TextInputType.none,
                            onTap: () async {
                              DateTime? date = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now()
                                    .subtract(Duration(days: 365)),
                                lastDate:
                                    DateTime.now().add(Duration(days: 365)),
                              );
                              if (date != null) {
                                this.date.text =
                                    BrasilDateFormat().formatDate(date);
                                if (time.text.isNotEmpty) {
                                  DateTime dateTime = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      dateTimeTask!.hour,
                                      dateTimeTask!.hour);
                                      dateTimeTask = dateTime;
                                }
                              }
                            },
                            controller: date,
                            decoration: InputDecoration(hintText: "Data"),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.4,
                          child: TextField(
                            keyboardType: TextInputType.none,
                            onTap: () async {
                              if (date.text == "") {
                                NoticeMenssages.showErrorMensager(
                                    "Selecione a data primeiro", context);
                                return;
                              }
                              TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              if (time != null) {
                                DateTime date = BrasilDateFormat()
                                    .dateFromBrasilDateTimeFormat(
                                        this.date.text);
                                DateTime dateTime = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    time.hour,
                                    time.minute);
                                dateTimeTask = dateTime;
                                this.time.text =
                                    BrasilDateFormat().formatTime(dateTime);
                              }
                            },
                            controller: time,
                            decoration: InputDecoration(hintText: "Hora"),
                          ),
                        ),
                      ],
                    ),
                    CheckboxListTile(
                      value: highPriority,
                      onChanged: (value) {
                        highPriority = value!;
                        setState(() {});
                      },
                      title: Text("Alta prioridade?"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (description.text.isEmpty) {
                            NoticeMenssages.showErrorMensager(
                                "É necessário preencher a descrição", context);
                            return;
                          }
                          if (dateTimeTask == null) {
                            NoticeMenssages.showErrorMensager(
                                "É necessário preencher a data", context);
                            return;
                          }
                          if (widget.todo != null) {
                            BlocProvider.of<UpdateTodoBloc>(context).add(
                                UpdateTodoUpdateEvent(
                                    todo: Todo(
                                      
                                        id: widget.todo!.id,
                                        taskDate:
                                            dateTimeTask!.toIso8601String(),
                                        creationDate:
                                            DateTime.now().toIso8601String(),
                                        deletedDate: null,
                                        description: description.text,
                                        done: widget.todo!.done,
                                        priority: highPriority ? 1 : 0,
                                        updatedDate:
                                            DateTime.now().toIso8601String())));
                          } else {
                            BlocProvider.of<CreateTodoBloc>(context).add(
                                CreateTodoCreateEvent(
                                    todo: Todo(
                                        taskDate:
                                            dateTimeTask!.toIso8601String(),
                                        creationDate:
                                            DateTime.now().toIso8601String(),
                                        deletedDate: null,
                                        description: description.text,
                                        done: false,
                                        priority: highPriority ? 1 : 0,
                                        updatedDate:
                                            DateTime.now().toIso8601String())));
                          }
                        },
                        child: Text("Salvar"))
                  ],
                );
              });
            },
          ),
        )),
      ),
    );
  }
}
