import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/model/task.dart';

part 'completed_tasks_event.dart';
part 'completed_tasks_state.dart';

class CompletedTasksBloc
    extends Bloc<CompletedTasksEvent, CompletedTasksState> {
  CompletedTasksBloc() : super(CompletedTasksState()) {
    on<LoadTask>((event, emit) {});
    on<AddTask>((event, emit) {
      List<Task> tasks = state.pendingTasks;
      tasks.add(event.task);
      emit(state.copyWith(pendingTasks: () => tasks));
    });
  }
}
