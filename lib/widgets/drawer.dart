import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:task_reporter/providers/group_api.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final groups = Provider.of<GroupApi>(context, listen: false).allGroups;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child:
                // Placeholder(),
                Image.network(
                    'https://telegra.ph/file/9aa2770b195550c2b113a.png'),
          ),
          FutureBuilder(
            future: Provider.of<GroupApi>(context, listen: false).getGroups(),
            builder: (context, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? SpinKitThreeBounce(
                    color: Colors.black,
                    size: 30,
                  )
                : snapshot.hasError
                    ? Center(child: Text(snapshot.error.toString()))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: groups.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(groups[index].name),
                          leading: const Icon(Icons.payment),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.pushNamed(
                              context,
                              'home',
                              arguments:
                                  Provider.of<GroupApi>(context, listen: false)
                                      .allGroups[index]
                                      .name
                                      .toString(),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
