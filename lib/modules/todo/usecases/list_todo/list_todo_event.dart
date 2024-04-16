part of 'list_todo_bloc.dart';

sealed class ListTodoEvent extends Equatable {
  const ListTodoEvent();

  @override
  List<Object> get props => [];
}

class ListTodoListByPriorityEvent extends ListTodoEvent {
  const ListTodoListByPriorityEvent({required this.done});
  final bool done;
  @override
  List<Object> get props => [];
}

class ListTodoListByDateEvent extends ListTodoEvent {
  const ListTodoListByDateEvent({required this.done, required this.byTaskDate});
  final bool done;
  final bool byTaskDate;
  @override
  List<Object> get props => [];
}
