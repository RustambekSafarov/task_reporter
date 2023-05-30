import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:task_reporter/providers/assignment_api.dart';
import 'package:task_reporter/widgets/assignment_tap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<AssignmentApi>(context, listen: false).getAssignments(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: SpinKitThreeInOut(
                    color: Colors.black,
                    size: 30,
                  ),
                )
              : snapshot.hasError
                  ? Center(
                      child: Text(snapshot.error.toString()),
                    )
                  : const AssignmentWidget();
        },
      ),
    );
  }
}
