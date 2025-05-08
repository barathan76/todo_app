import 'package:bloc/bloc.dart';
import 'package:todo_repo/todo_repo.dart';
import 'package:todo_app/version_4/db/data.dart';
part 'completed_task_event.dart';
part 'completed_task_state.dart';

class CompletedTaskBloc extends Bloc<CompletedTaskEvent, CompletedTaskState> {
  TodoRepo todoRepo = TodoRepository();
  CompletedTaskBloc() : super(CompletedTaskInitial()) {
    on<LoadTask>((event, emit) async {
      print("called");
      emit(CompletedTaskInitial());
      Data data = Data();
      List<Task> task = data.completedTasks;
      emit(CompletedTaskLoaded(completedTask: task));
      // emit(CompletedTaskInitial());
      // List<Task> task = await todoRepo.completedTask;
      // emit(CompletedTaskLoaded(completedTask: task));
    });

    on<AddTask>((event, emit) {
      event.task.isCompleted = true;
      List<Task> completedTask = List<Task>.from(state.completedTask)
        ..add(event.task);
      emit(CompletedTaskUpdated(completedTask: completedTask));
      // event.task.isCompleted = true;
      // List<Task> completedTask = List<Task>.from(state.completedTask)
      //   ..add(event.task);
      // todoRepo.addTask(event.task);
      // emit(CompletedTaskUpdated(completedTask: completedTask));
    });
    on<InsertTask>((event, emit) {
      List<Task> task = List<Task>.from(state.completedTask)
        ..insert(event.index, event.task);
      emit(CompletedTaskUpdated(completedTask: task));
      // List<Task> task = List<Task>.from(state.completedTask)
      //   ..insert(event.index, event.task);
      // emit(CompletedTaskUpdated(completedTask: task));
    });

    on<RemoveTask>((event, emit) {
      event.task.isCompleted = false;
      List<Task> task = List<Task>.from(state.completedTask)
        ..remove(event.task);
      emit(CompletedTaskUpdated(completedTask: task));
      // event.task.isCompleted = false;
      // List<Task> task = List<Task>.from(state.completedTask)
      //   ..remove(event.task);
      // emit(CompletedTaskUpdated(completedTask: task));
    });
    on<DeleteTask>((event, emit) {
      List<Task> task = List<Task>.from(state.completedTask)
        ..remove(event.task);
      emit(CompletedTaskUpdated(completedTask: task));
      // List<Task> task = List<Task>.from(state.completedTask)
      //   ..remove(event.task);
      // todoRepo.deleteTask(event.task);
      // emit(CompletedTaskUpdated(completedTask: task));
    });
  }
}
