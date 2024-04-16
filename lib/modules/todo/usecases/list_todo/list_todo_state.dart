part of 'list_todo_bloc.dart';

sealed class ListTodoState extends Equatable {
  const ListTodoState();

  @override
  List<Object> get props => [];
}

final class ListTodoInitial extends ListTodoState {}

final class ListTodoLoading extends ListTodoState {}

final class ListTodoError extends ListTodoState {}

final class ListTodoSuccess extends ListTodoState {
  const ListTodoSuccess({required this.todoList});
  final List<Todo> todoList;
}
