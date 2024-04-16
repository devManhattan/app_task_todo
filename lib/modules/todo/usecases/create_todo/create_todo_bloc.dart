import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_moura/modules/todo/models/todo.dart';
import 'package:todo_moura/modules/todo/repository/repository_interface.dart';

part 'create_todo_event.dart';
part 'create_todo_state.dart';

class CreateTodoBloc extends Bloc<CreateTodoEvent, CreateTodoState> {
  CreateTodoBloc() : super(CreateTodoInitial()) {
    on<CreateTodoEvent>((event, emit) async {
      // TODO: implement event handler
      todoRepository = GetIt.instance.get<ITodoRepository>();
      if (event is CreateTodoCreateEvent) {
        try {
          emit(CreateTodoLoading());
          bool result = await todoRepository.create(event.todo);
          if (result) {
            emit(CreateTodoSuccess());
          } else {
            emit(CreateTodoError());
          }
        } catch (e) {
          emit(CreateTodoError());
        }
      }
    });
  }
  late ITodoRepository todoRepository;
}
