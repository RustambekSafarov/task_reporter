// ignore_for_file: unused_field, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/assignment_api.dart';
import '../screens/results_screen.dart';

class AssignmentWidget extends StatefulWidget {
  String? groupName;
  AssignmentWidget({super.key, this.groupName});

  @override
  State<AssignmentWidget> createState() => _AssignmentWidgetState();
}

class _AssignmentWidgetState extends State<AssignmentWidget> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<AssignmentApi>(
      builder: (context, value, child) => Card(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white54,
          ),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: ListView.builder(
                  itemCount: value.allAssignment.length,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      selected: _index == index,
                      selectedTileColor: Colors.blue[50],
                      title: Text(
                        value.allAssignment[index].name,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 110, 109, 109),
                        ),
                      ),
                      onTap: () async {
                        // await Provider.of<ResultApi>(context, listen: false).getResult(
                        //   value.allAssignment[index].courseId,
                        //   value.allAssignment[index].id,
                        // );
                        Provider.of<AssignmentApi>(context, listen: false)
                            .onVisible(true);
                        setState(() {
                          _index = index;
                        });
                        print(value.allAssignment[_index].name);

                        // context.goNamed(
                        //   ResultScreen.routeName,
                        //   params: {
                        //     'assignmentId':
                        //         value.allAssignment![index].id.toString(),
                        //     'lessonId': Provider.of<AssignmentApi>(context,
                        //             listen: false)
                        //         .lessonId
                        //         .toString(),
                        //   },
                        // );
                      },
                    ),
                  ),
                ),
              ),
              if (Provider.of<AssignmentApi>(context).resultVisible)
                Flexible(
                  flex: 4,
                  child: Provider.of<AssignmentApi>(context).resultVisible
                      ? ResultScreen(
                          name: value.allAssignment[_index].name,
                          groupName: widget.groupName ?? 'no',
                        )
                      : Center(
                          child: Text('Please, choose the assignment'),
                        ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
