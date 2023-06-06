import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_reporter/providers/assignment_api.dart';
import 'package:task_reporter/providers/group_api.dart';
import 'package:task_reporter/providers/result_api.dart';
import 'package:task_reporter/screens/groups_screen.dart';
import 'package:task_reporter/screens/home_screen.dart';

void main() {
  runApp(const MyRoot());
}

class MyRoot extends StatefulWidget {
  const MyRoot({super.key});

  @override
  State<MyRoot> createState() => _MyRootState();
}

class _MyRootState extends State<MyRoot> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AssignmentApi()),
        ChangeNotifierProvider(create: (context) => ResultApi()),
        ChangeNotifierProvider(create: (context) => GroupApi()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Students task reporter',
        routes: {
          '/': (context) => const GroupsScreen(),
          'home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
