import 'package:flutter/material.dart';

class DashboardEntityDataDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
    // return FutureBuilder(
    //   future: GetIt.instance<PatientGqlRepository>().search(),
    //   builder: (context, snapshot) {
    //     if (snapshot.data != null) {
    //       final data = snapshot.data!;
    //       return ListView.builder(
    //         itemBuilder: (context, index) {
    //           final item = data.items[index];
    //           return Text(item.toString());
    //         },
    //         itemCount: data.items.length,
    //       );
    //     } else {
    //       return Text('Error in query');
    //     }
    //   },
    // );
  }
}
