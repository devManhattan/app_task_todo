part of 'create_todo_bloc.dart';

sealed class CreateTodoEvent extends Equatable {
  const CreateTodoEvent();

  @override
  List<Object> get props => [];
}

 class CreateTodoCreateEvent extends CreateTodoEvent {
  const CreateTodoCreateEvent({required this.todo});
  final Todo todo;
  @override
  List<Object> get props => [];
}
