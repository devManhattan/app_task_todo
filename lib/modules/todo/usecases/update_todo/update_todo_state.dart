part of 'update_todo_bloc.dart';

sealed class UpdateTodoState extends Equatable {
  const UpdateTodoState();

  @override
  List<Object> get props => [];
}

final class UpdateTodoInitial extends UpdateTodoState {}

final class UpdateTodoLoading extends UpdateTodoState {}

final class UpdateTodoError extends UpdateTodoState {}

final class UpdateTodoSuccess extends UpdateTodoState {}
