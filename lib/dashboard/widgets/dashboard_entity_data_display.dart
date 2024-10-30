import 'package:firearrow_admin_app/dashboard/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardEntityDataDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardCubitState>(
      builder: (context, state) {
        return state.when(
          noselected: () => Text('null'),
          selected: (entityType) => Text(entityType),
        );
      },
    );

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
