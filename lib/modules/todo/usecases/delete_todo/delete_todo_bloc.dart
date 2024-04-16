import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_moura/modules/todo/models/todo.dart';
import 'package:todo_moura/modules/todo/repository/repository_interface.dart';

part 'delete_todo_event.dart';
part 'delete_todo_state.dart';

class DeleteTodoBloc extends Bloc<DeleteTodoEvent, DeleteTodoState> {
  DeleteTodoBloc() : super(DeleteTodoInitial()) {
    on<DeleteTodoEvent>((event, emit) async {
      // TODO: implement event handler
      todoRepository = GetIt.instance.get<ITodoRepository>();
      if (event is DeleteTodoDeleteEvent) {
        try {
          emit(DeleteTodoLoading());
          bool result = await todoRepository.delete(event.todo);
          if (result) {
            emit(DeleteTodoSuccess());
          } else {
            emit(DeleteTodoError());
          }
        } catch (e) {
          emit(DeleteTodoError());
        }
      }
    });
  }
  late ITodoRepository todoRepository;
}
