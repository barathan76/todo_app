import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_task_event.dart';
part 'create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  CreateTaskBloc() : super(CreateTaskState()) {
    on<SaveTitleEvent>((event, emit) {
      emit(state.copyWith(title: () => event.title));

      print("taskupdate");
    });
    on<SaveDateEvent>((event, emit) {
      emit(state.copyWith(dueDate: () => event.date));
      print("taskupdate");
    });
    on<SaveDescEvent>((event, emit) {
      emit(state.copyWith(description: () => event.desc));
      print("taskupdate");
    });
    on<SaveImpEvent>((event, emit) {
      emit(state.copyWith(isImportant: () => event.imp));
      print("taskupdate");
    });
    on<SaveTaskEvent>((event, emit) {
      emit(state.copyWith());
    });
  }
}
