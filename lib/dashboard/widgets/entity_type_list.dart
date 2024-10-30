import 'package:firearrow_admin_app/dashboard/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntityTypeList extends StatelessWidget {
  final List<String> listOfEntities;

  const EntityTypeList({
    super.key,
    required this.listOfEntities,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return EntityTypeListCard(
          entityType: listOfEntities[index],
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          width: double.infinity,
          height: 1,
          color: Theme.of(context).colorScheme.outlineVariant,
        );
      },
      itemCount: listOfEntities.length,
    );
  }
}

class EntityTypeListCard extends StatelessWidget {
  final String entityType;
  const EntityTypeListCard({
    super.key,
    required this.entityType,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardCubitState>(
      builder: (context, state) {
        final isSelected = state.when(
          noselected: () => false,
          selected: (itemSelected) => itemSelected == entityType,
        );

        return FilledButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.surface,
            ),
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
          onPressed: isSelected
              ? null
              : () => BlocProvider.of<DashboardCubit>(context).select(
                    entityType: entityType,
                  ),
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 16,
              ),
              child: Text(
                entityType.toString(),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isSelected
                          ? Theme.of(context).colorScheme.onPrimary
                          : null,
                    ),
              ),
            ),
          ),
        );
      },
    );
  }
}
