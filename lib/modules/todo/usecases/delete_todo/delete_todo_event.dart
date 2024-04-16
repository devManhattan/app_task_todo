part of 'delete_todo_bloc.dart';

sealed class DeleteTodoEvent extends Equatable {
  const DeleteTodoEvent();

  @override
  List<Object> get props => [];
}


 class DeleteTodoDeleteEvent extends DeleteTodoEvent {
  const DeleteTodoDeleteEvent({
    required this.todo
  });
  
  final Todo todo;
  @override
  List<Object> get props => [];
}
