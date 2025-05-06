import 'package:flutter/material.dart';
import 'package:todo_app/version_4/bloc/completed_task_bloc/completed_task_bloc.dart';
import 'package:todo_app/version_4/bloc/pending_task_bloc/pending_task_bloc.dart';
import 'package:todo_app/version_4/homescreen.dart';
import 'package:todo_app/version_4/db/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/version_4/presentation/widgets/color_scheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Data().loadTasks();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CompletedTaskBloc()),
        BlocProvider(create: (context) => PendingTaskBloc()),
      ],
      child: MaterialApp(
        home: HomeScreen(),
        theme: ThemeData(colorScheme: kColorScheme),
      ),
    );
  }
}
