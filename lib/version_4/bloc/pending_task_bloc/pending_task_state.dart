part of 'pending_task_bloc.dart';

sealed class PendingTaskState {
  List<Task> pendingTask;
  PendingTaskState({this.pendingTask = const []});
}

class PendingTaskInitial extends PendingTaskState {
  PendingTaskInitial({super.pendingTask});
}

class PendingTaskUpdated extends PendingTaskState {
  PendingTaskUpdated({super.pendingTask});
}

class PendingTaskLoaded extends PendingTaskState {
  PendingTaskLoaded({super.pendingTask});
}
