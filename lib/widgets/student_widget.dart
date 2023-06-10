import 'package:flutter/material.dart';

import '../models/student.dart';

class StudentTapWidget extends StatefulWidget {
  final List<Student> data;
  const StudentTapWidget({super.key, this.data = const []});

  @override
  State<StudentTapWidget> createState() => _StudentTapWidgetState();
}

class _StudentTapWidgetState extends State<StudentTapWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 1000,
            child: ListTile(
              title: Text(widget.data[index].lastName),
              subtitle: Text(widget.data[index].firstName),
            ),
          );
        },
      ),
    );
  }
}
