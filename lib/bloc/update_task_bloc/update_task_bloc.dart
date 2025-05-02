import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_task_event.dart';
part 'update_task_state.dart';

class UpdateTaskBloc extends Bloc<UpdateTaskEvent, UpdateTaskState> {
  UpdateTaskBloc() : super(UpdateTaskInitial()) {
    on<UpdateTaskEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
