import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'task_operation_event.dart';
part 'task_operation_state.dart';

class TaskOperationBloc extends Bloc<TaskOperationEvent, TaskOperationState> {
  TaskOperationBloc() : super(TaskOperationInitial()) {
    on<TaskOperationEvent>((event, emit) {});
  }
}
