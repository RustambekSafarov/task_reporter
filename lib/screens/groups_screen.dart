import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/group_api.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 12),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      _key.currentState!.openDrawer();
                    },
                    icon: const Icon(Icons.menu)),
                const SizedBox(width: 10),
                const Text('Groups', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black)),
              ],
            ),
          ),
          FutureBuilder(
              future: Provider.of<GroupApi>(context, listen: false).getGroups(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // TODO: Change a loading screen here
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                return Container(
                  padding: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.9,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: Provider.of<GroupApi>(context, listen: false).allGroups.length,
                    itemBuilder: (context, index) => Card(
                      child: ListTile(
                        title: Text(
                          Provider.of<GroupApi>(context, listen: false).allGroups[index].name,
                          style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 110, 109, 109)),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, 'home', arguments: Provider.of<GroupApi>(context, listen: false).allGroups[index].name.toString());
                        },
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
