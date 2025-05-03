import 'package:bloc/bloc.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/version_2/db/data.dart';

part 'pending_task_event.dart';
part 'pending_task_state.dart';

class PendingTaskBloc extends Bloc<PendingTaskEvent, PendingTaskState> {
  PendingTaskBloc() : super(PendingTaskInitial()) {
    on<LoadPendingTask>((event, emit) {
      Data data = Data();
      List<Task> task = data.pendingTasks;
      emit(PendingTaskLoaded(pendingTask: task));
    });

    on<InsertPendingTask>((event, emit) {
      List<Task> pendingTask = List<Task>.from(state.pendingTask)
        ..insert(event.index, event.task);
      emit(PendingTaskUpdated(pendingTask: pendingTask));
    });

    on<RemovePendingTask>((event, emit) {
      List<Task> pendingTask = List<Task>.from(state.pendingTask)
        ..remove(event.task);
      emit(PendingTaskUpdated(pendingTask: pendingTask));
    });

    on<UpdatePendingTask>((event, emit) {
      List<Task> pendingTask =
          List<Task>.from(state.pendingTask)
            ..removeAt(event.index)
            ..insert(event.index, event.task);
      emit(PendingTaskUpdated(pendingTask: pendingTask));
    });
    on<AddPendingTask>((event, emit) {
      List<Task> pendingTask = List<Task>.from(state.pendingTask)
        ..add(event.task);
      emit(PendingTaskUpdated(pendingTask: pendingTask));
    });
  }
}
