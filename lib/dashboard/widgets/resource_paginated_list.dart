import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:fhir_rest_client/fhir_rest_client.dart';
import 'package:fire_scribe/auth/cubit/fhir_server_connection_cubit.dart';
import 'package:fire_scribe/dashboard/cubit/dashboard_cubit.dart';
import 'package:fire_scribe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

class ResourcePaginatedList extends StatefulWidget {
  const ResourcePaginatedList({
    super.key,
  });

  @override
  State<ResourcePaginatedList> createState() => _ResourcePaginatedListState();
}

class _ResourcePaginatedListState extends State<ResourcePaginatedList> {
  final pagingController = PagingController<int, Resource>(firstPageKey: 0);
  String? entitySelected;
  String? searchCursor;

  @override
  void initState() {
    super.initState();
    pagingController.addPageRequestListener(fetchPage);
  }

  @override
  void dispose() {
    pagingController.removePageRequestListener(fetchPage);
    pagingController.dispose();
    super.dispose();
  }

  Future<void> fetchPage(final int pageOffset) async {
    if (entitySelected == null || entitySelected!.isEmpty) {
      pagingController.appendLastPage([]);
      return;
    }

    final parameters = {
      '_sort': '-_lastUpdated',
      '_count': '25',
    };

    if (searchCursor != null) {
      parameters['ct'] = searchCursor!;
    }

    final rawBundle =
        await BlocProvider.of<FhirServerConnectionCubit>(context).request(
      request: FhirRequest(
        operation: FhirRequestOperation.search,
        entityName: entitySelected!,
        parameters: parameters,
      ),
    );
    if (rawBundle == null) {
      pagingController.appendLastPage([]);
      return;
    }
    final bundle = Bundle.fromJson(rawBundle);
    final nextUrl =
        bundle.link?.firstWhereOrNull((item) => item.relation == 'next')?.url;
    searchCursor = nextUrl?.value?.queryParameters['ct'];

    final entries = (bundle.entry ?? <BundleEntry>[])
        .map((entry) => entry.resource)
        .whereNotNull()
        .toList();

    if (searchCursor == null) {
      pagingController.appendLastPage(entries);
    } else {
      pagingController.appendPage(
        entries,
        (pagingController.itemList?.length ?? 0) + entries.length,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardCubitState>(
      listener: (context, state) {
        state.when(
          noselected: () {},
          selected: (entitySelected) async {
            setState(() {
              this.entitySelected = entitySelected;
            });
            pagingController.refresh();
          },
        );
      },
      builder: (context, state) {
        return state.when(
          noselected: () => Center(
            child: Text(
              S.of(context).selectAnEntityFromList,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          selected: (entitySelected) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 48,
                  ),
                  child: ResourcePaginatedListHeader(
                    entityType: entitySelected,
                  ),
                ),
                Expanded(
                  child: PagedListView<int, Resource>.separated(
                    pagingController: pagingController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemExtent: 80,
                    builderDelegate: PagedChildBuilderDelegate<Resource>(
                      newPageProgressIndicatorBuilder: (context) =>
                          const Center(
                        child: CircularProgressIndicator(),
                      ),
                      noItemsFoundIndicatorBuilder: (context) => Center(
                        child: Text(
                          S.of(context).noDataAssociatedToAnEntity,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      noMoreItemsIndicatorBuilder: (context) =>
                          const SizedBox(),
                      itemBuilder: (context, item, index) {
                        return ResourcePaginatedListCard(resource: item);
                      },
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 2),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class ResourcePaginatedListHeader extends StatelessWidget {
  final String entityType;

  const ResourcePaginatedListHeader({
    super.key,
    required this.entityType,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).entityTypeIdHeader(entityType),
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Text(
          S.of(context).lastUpdate,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}

class ResourcePaginatedListCard extends StatelessWidget {
  final Resource resource;

  const ResourcePaginatedListCard({
    super.key,
    required this.resource,
  });

  @override
  Widget build(BuildContext context) {
    final iso8601String = resource.meta?.lastUpdated?.toIso8601String();
    final dateTime =
        iso8601String != null ? DateTime.parse(iso8601String) : null;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            resource.fhirId ?? S.of(context).noData,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            dateTime != null
                ? DateFormat.yMd().format(dateTime)
                : S.of(context).noData,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
