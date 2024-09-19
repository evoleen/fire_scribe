import 'package:auth_cubit/auth_cubit.dart';
import 'package:evoleen_fhir/evoleen_fhir.dart';
import 'package:firearrow_admin_app/auth/azure_identity_provider_cubit.dart';
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
            child: BlocBuilder<AzureIdentityProviderCubit, AuthProviderState>(
              bloc: BlocProvider.of<AuthCubit>(context)
                  .provider<AzureIdentityProviderCubit>(),
              builder: (context, state) {
                return state.maybeWhen(
                  authenticated: (_) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return EntityCard(
                          type: supportedTypes[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          height: 1,
                          color: Theme.of(context).colorScheme.outlineVariant,
                        );
                      },
                      itemCount: supportedTypes.length,
                    );
                  },
                  unauthenticated: () {
                    return SizedBox();
                  },
                  orElse: () => Center(
                    child: CircularProgressIndicator(),
                  ),
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
