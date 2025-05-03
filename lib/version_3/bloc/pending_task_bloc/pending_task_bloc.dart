import 'package:bloc/bloc.dart';
import 'package:todo_repo/todo_repo.dart';

part 'pending_task_event.dart';
part 'pending_task_state.dart';

class PendingTaskBloc extends Bloc<PendingTaskEvent, PendingTaskState> {
  TodoRepo todoRepo = TodoRepository();
  PendingTaskBloc() : super(PendingTaskInitial()) {
    on<LoadPendingTask>((event, emit) async {
      List<Task> task = await todoRepo.pendingTask;
      print(task);
      emit(PendingTaskLoaded(pendingTask: task));
    });

    on<InsertPendingTask>((event, emit) {
      List<Task> pendingTask = List<Task>.from(state.pendingTask)
        ..insert(event.index, event.task);
      todoRepo.addTask(event.task);
      emit(PendingTaskUpdated(pendingTask: pendingTask));
    });

    on<RemovePendingTask>((event, emit) {
      List<Task> pendingTask = List<Task>.from(state.pendingTask)
        ..remove(event.task);
      todoRepo.deleteTask(event.task);
      emit(PendingTaskUpdated(pendingTask: pendingTask));
    });

    on<UpdatePendingTask>((event, emit) {
      print(event.task);
      List<Task> pendingTask =
          List<Task>.from(state.pendingTask)
            ..removeAt(event.index)
            ..insert(event.index, event.task);
      todoRepo.updateTask(event.task);
      emit(PendingTaskUpdated(pendingTask: pendingTask));
    });
    on<AddPendingTask>((event, emit) {
      List<Task> pendingTask = List<Task>.from(state.pendingTask)
        ..add(event.task);
      todoRepo.addTask(event.task);
      emit(PendingTaskUpdated(pendingTask: pendingTask));
    });
  }
}
