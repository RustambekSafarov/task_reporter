// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_reporter/providers/student_api.dart';
import 'package:task_reporter/widgets/assignment_tap.dart';
import 'package:task_reporter/widgets/student_widget.dart';

import '../providers/assignment_api.dart';
import '../widgets/drawer.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String?;
    return DefaultTabController(
      length: 3,
      animationDuration: const Duration(milliseconds: 100),
      child: Scaffold(
        key: _key,
        endDrawerEnableOpenDragGesture: false,
        drawer: const DrawerWidget(),
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _key.currentState!.openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    args ?? 'No Group Selected',
                    style: GoogleFonts.monda(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  // const SizedBox(width: 10),
                  const Spacer(),
                  const Expanded(
                    flex: 2,
                    child: TabBar(
                      dividerColor: Colors.grey,
                      indicatorColor: Colors.orange,
                      labelColor: Colors.orange,
                      unselectedLabelColor: Colors.black,
                      labelStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 119, 115, 115),
                      ),
                      tabs: [
                        Tab(text: 'Assignments'),
                        Tab(text: 'Students'),
                        Tab(text: 'Teachers'),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  FutureBuilder(
                    future: Provider.of<AssignmentApi>(context, listen: false)
                        .getAssignments(),
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
                              : AssignmentWidget(
                                  groupName: args,
                                );
                    },
                  ),
                  FutureBuilder(
                    future: Provider.of<StudentApi>(context, listen: false)
                        .getStudents(),
                    builder: (context, snapshot) => StudentTapWidget(
                        data: Provider.of<StudentApi>(context, listen: false)
                            .students),
                  ),
                  Center(
                    child: Text('Teachers'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
