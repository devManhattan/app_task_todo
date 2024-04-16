part of 'update_todo_bloc.dart';

sealed class UpdateTodoEvent extends Equatable {
  const UpdateTodoEvent();

  @override
  List<Object> get props => [];
}

 class UpdateTodoUpdateEvent extends UpdateTodoEvent {
  const UpdateTodoUpdateEvent({required this.todo});
  final Todo todo;
  @override
  List<Object> get props => [];
}
