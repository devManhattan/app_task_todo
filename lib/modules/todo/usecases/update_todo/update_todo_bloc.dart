import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_moura/modules/todo/models/todo.dart';
import 'package:todo_moura/modules/todo/repository/repository_interface.dart';

part 'update_todo_event.dart';
part 'update_todo_state.dart';

class UpdateTodoBloc extends Bloc<UpdateTodoEvent, UpdateTodoState> {
  UpdateTodoBloc() : super(UpdateTodoInitial()) {
    on<UpdateTodoEvent>((event, emit) async {
      // TODO: implement event handler

      todoRepository = GetIt.instance.get<ITodoRepository>();
      try {
        if (event is UpdateTodoUpdateEvent) {
          emit(UpdateTodoLoading());
          bool result = await todoRepository.update(event.todo);
          if (result) {
            emit(UpdateTodoSuccess());
          } else {
            emit(UpdateTodoError());
          }
        }
      } catch (e) {
        emit(UpdateTodoError());
      }
    });
  }
  late ITodoRepository todoRepository;
}
