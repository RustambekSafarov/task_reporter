import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/group_api.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<GroupApi>(context, listen: false).getGroups(),
        builder: (context, snapshot) => Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white54,
            ),
            child: ListView.builder(
              itemCount: Provider.of<GroupApi>(context, listen: false).allGroups.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text(
                    Provider.of<GroupApi>(context, listen: false).allGroups[index].name,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 110, 109, 109),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'home',
                      arguments: Provider.of<GroupApi>(context, listen: false).allGroups[index].name.toString(),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
