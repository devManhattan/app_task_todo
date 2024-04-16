import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_moura/modules/todo/models/todo.dart';
import 'package:todo_moura/modules/todo/repository/repository_interface.dart';

part 'list_todo_event.dart';
part 'list_todo_state.dart';

class ListTodoBloc extends Bloc<ListTodoEvent, ListTodoState> {
  ListTodoBloc() : super(ListTodoInitial()) {
    on<ListTodoEvent>((event, emit) async {
      // TODO: implement event handler
      todoRepository = GetIt.instance.get<ITodoRepository>();
      if (event is ListTodoListByPriorityEvent) {
        try {
          emit(ListTodoLoading());

          List<Todo> todoList =
              await todoRepository.getByPrioridade(event.done);

          emit(ListTodoSuccess(todoList: todoList));
        } catch (e, stackTrace) {
          emit(ListTodoError());
        }
      }

      if (event is ListTodoListByDateEvent) {
        try {
          emit(ListTodoLoading());
          List<Todo> todoList = [];
          if (event.byTaskDate) {
            todoList = await todoRepository.getByTaskDate(event.done);
          } else {
            todoList = await todoRepository.getByCreationDate(event.done);
          }
          emit(ListTodoSuccess(todoList: todoList));
        } catch (e, stackTrace) {
          emit(ListTodoError());
        }
      }
    });
  }
  late ITodoRepository todoRepository;
}
