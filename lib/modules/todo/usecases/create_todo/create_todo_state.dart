part of 'create_todo_bloc.dart';

sealed class CreateTodoState extends Equatable {
  const CreateTodoState();
  
  @override
  List<Object> get props => [];
}

final class CreateTodoInitial extends CreateTodoState {}


final class CreateTodoLoading extends CreateTodoState {}


final class CreateTodoError extends CreateTodoState {}


final class CreateTodoSuccess extends CreateTodoState {}
