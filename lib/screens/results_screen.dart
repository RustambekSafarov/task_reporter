// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:task_reporter/providers/result_api.dart';

class ResultScreen extends StatelessWidget {
  String name;
  ResultScreen({super.key, required this.name});
  static const routeName = 'result-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: Provider.of<ResultApi>(context, listen: false).getResult(name),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitThreeInOut(
                  color: Colors.black,
                  size: 30,
                ),
              );
            } else if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Consumer<ResultApi>(
                  builder: (context, value, child) => SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        border: TableBorder.all(),
                        columns: [
                          const DataColumn(
                            label: Text(
                              'Fullname',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const DataColumn(
                            label: Text('Total'),
                          ),
                          ...List.generate(
                            snapshot.data![0].tasks.length,
                            (index) => DataColumn(
                              label: Text("${index + 1} task"),
                            ),
                          ),
                          // const DataColumn(
                          //   label: Text(
                          //     'Attempts',
                          //   ),
                          // ),
                        ],
                        rows: snapshot.data!
                            .map(
                              (e) => DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      e.student['first_name'] + ' ' + e.student['last_name'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      e.rightAnswers.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  ...e.tasks.map(
                                    (e) => DataCell(
                                      Text(e['is_correct'] ? '✅' : '❌'),
                                    ),
                                  ),
                                  // DataCell(
                                  //   Center(
                                  //     child: Text(
                                  //       e.rightAnswers.toString(),
                                  //       style: const TextStyle(
                                  //         fontSize: 20,
                                  //         fontWeight: FontWeight.w500,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
          }),
    );
  }
}
