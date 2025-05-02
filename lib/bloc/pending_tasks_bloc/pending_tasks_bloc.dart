import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/misc/sample_data.dart';
import 'package:todo_app/model/task.dart';

part 'pending_tasks_event.dart';
part 'pending_tasks_state.dart';

class PendingTasksBloc extends Bloc<PendingTasksEvent, PendingTasksState> {
  PendingTasksBloc() : super(PendingTasksState()) {
    on<LoadTask>((event, emit) {
      print(this);
      emit(state.copyWith(pendingTasks: () => sampleData));
    });
    on<AddTask>((event, emit) {
      print(this);
      List<Task> tasks = [...state.pendingTasks];
      print("task is added");

      emit(state.copyWith(pendingTasks: () => tasks));
      print(state.pendingTasks);
    });

    on<DeleteTask>((event, emit) {
      List<Task> tasks = state.pendingTasks;
      tasks.remove(event.task);

      emit(state.copyWith(pendingTasks: () => tasks));
    });
  }
}
