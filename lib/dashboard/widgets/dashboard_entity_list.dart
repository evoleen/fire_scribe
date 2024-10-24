import 'package:evoleen_fhir/evoleen_fhir.dart';
import 'package:firearrow_admin_app/connection/cubit/fhir_repositories_cubit.dart';
import 'package:firearrow_admin_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardEntityList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Text(
            S.of(context).allResources,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerLowest,
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
            child:
                BlocBuilder<FhirRepositoriesCubit, FhirRepositoriesCubitState>(
              builder: (context, state) {
                return state.when(
                  connected: (_) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return EntityCard(
                          type: EvoleenFhirSchema.entityToRepository.keys
                              .elementAt(index),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          height: 1,
                          color: Theme.of(context).colorScheme.outlineVariant,
                        );
                      },
                      itemCount:
                          EvoleenFhirSchema.entityToRepository.keys.length,
                    );
                  },
                  disconnected: () {
                    return SizedBox();
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class EntityCard extends StatelessWidget {
  final Type type;
  const EntityCard({super.key, required this.type});
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor:
            WidgetStatePropertyAll(Theme.of(context).colorScheme.surface),
        overlayColor: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.surfaceContainerLow,
        ),
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
      onPressed: null,
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 16,
          ),
          child: Text(
            type.toString(),
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
