part of 'completed_task_bloc.dart';

sealed class CompletedTaskState {
  List<Task> completedTask;
  CompletedTaskState({this.completedTask = const []});
  CompletedTaskState copyWith(List<Task> Function()? completedTask);
}

class CompletedTaskInitial extends CompletedTaskState {
  CompletedTaskInitial({super.completedTask});
  @override
  CompletedTaskInitial copyWith(List<Task> Function()? completedTask) {
    return CompletedTaskInitial(
      completedTask:
          completedTask != null ? completedTask() : this.completedTask,
    );
  }
}

class CompletedTaskLoaded extends CompletedTaskState {
  CompletedTaskLoaded({super.completedTask});
  @override
  CompletedTaskLoaded copyWith(List<Task> Function()? completedTask) {
    return CompletedTaskLoaded(
      completedTask:
          completedTask != null ? completedTask() : this.completedTask,
    );
  }
}

class CompletedTaskUpdated extends CompletedTaskState {
  CompletedTaskUpdated({super.completedTask});
  @override
  CompletedTaskUpdated copyWith(List<Task> Function()? completedTask) {
    return CompletedTaskUpdated(
      completedTask:
          completedTask != null ? completedTask() : this.completedTask,
    );
  }
}
