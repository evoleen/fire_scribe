import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:fhir_rest_client/fhir_rest_client.dart';
import 'package:firearrow_admin_app/dashboard/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class EntityData {
  final String? fhirId;
  final FhirInstant? lastUpdate;
  final String rawDataJson;

  EntityData({
    this.fhirId,
    this.lastUpdate,
    required this.rawDataJson,
  });
}

class EntityDataPaginatedList extends StatefulWidget {
  final FhirRestClient fhirRestClient;
  static const int pageSize = 20;

  const EntityDataPaginatedList({
    super.key,
    required this.fhirRestClient,
  });

  @override
  State<EntityDataPaginatedList> createState() =>
      _EntityDataPaginatedListState();
}

class _EntityDataPaginatedListState extends State<EntityDataPaginatedList> {
  PagingController<int, EntityData> pagingController =
      PagingController(firstPageKey: 0);
  String? searchOffset;
  CancelableOperation<void>? _searchOperation;
  Set<String> alreadyInListPatientIds = {};
  String? entitySelected;

  @override
  void initState() {
    super.initState();
    pagingController.addPageRequestListener(fetchPage);
  }

  @override
  void dispose() {
    _searchOperation?.cancel();
    pagingController.removePageRequestListener(fetchPage);
    pagingController.dispose();
    alreadyInListPatientIds = {};
    super.dispose();
  }

  Future<void> fetchPage(final int pageOffset) async {
    if (entitySelected == null || entitySelected!.isEmpty) {
      pagingController.appendLastPage([]);
      return;
    }
    // var isCanceled = false;

    // Future<void> searchPatients() async {
    //   try {

    final rawBundle = await widget.fhirRestClient.execute(
      request: FhirRequest(
        operation: FhirRequestOperation.search,
        entityName: entitySelected!,
      ),
    );
    final bundle = Bundle.fromJson(rawBundle);

    final entries = (bundle.entry ?? <BundleEntry>[])
        .map((entry) {
          if (entry.resource?.resourceType?.name == entitySelected) {
            return EntityData(
              fhirId: entry.resource?.fhirId,
              lastUpdate: entry.resource?.meta?.lastUpdated,
              rawDataJson: entry.resource?.toJsonString() ?? '',
            );
          } else {
            return null;
          }
        })
        .whereNotNull()
        .toList();

    pagingController.appendLastPage(entries);

    // if (isCanceled) {
    //   AppLogger.instance.d('Aborting searchMethod()');
    //   pagingController.appendLastPage([]);
    //   return;
    // }

    // searchOffset = searchResult.next;

    // if (searchResult.items.length == DashboardEntityDataDisplay.pageSize &&
    //     searchOffset != null) {
    //   pagingController.appendPage(
    //     searchResult.items.map((final e) => e.item).where((final patient) {
    //       final contains = alreadyInListPatientIds.contains(patient.fhirId);

    //       if (!contains) {
    //         alreadyInListPatientIds.add(patient.fhirId ?? '');
    //       }

    //       return !contains ? true : false;
    //     }).toList(),
    //     pageOffset + 1,
    //   );
    // } else {
    //   pagingController.appendLastPage(
    //     searchResult.items.map((final e) => e.item).where((final patient) {
    //       final contains = alreadyInListPatientIds.contains(patient.fhirId);

    //       if (!contains) {
    //         alreadyInListPatientIds.add(patient.fhirId ?? '');
    //       }

    //       return !contains ? true : false;
    //     }).toList(),
    //   );
    // }
    // } catch (e) {
    //   AppLogger.instance.e(e);
    //   pagingController.appendLastPage([]);
    // }
    // }

    // _searchOperation = CancelableOperation.fromFuture(
    //   searchPatients(),
    //   onCancel: () {
    //     isCanceled = true;
    //   },
    // );

    // return _searchOperation?.value;
  }

  Future<void> refresh() async {
    await _searchOperation?.cancel();
    searchOffset = null;
    pagingController.refresh();
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
            await refresh();
          },
        );
      },
      builder: (context, state) {
        return state.when(
          noselected: () => Center(
            child: CircularProgressIndicator(),
          ),
          selected: (entitySelected) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 48,
                  ),
                  child: EntityDataPaginatedListHeader(
                    entityType: entitySelected,
                  ),
                ),
                Expanded(
                  child: PagedListView<int, EntityData>.separated(
                    pagingController: pagingController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemExtent: 80,
                    builderDelegate: PagedChildBuilderDelegate<EntityData>(
                      newPageProgressIndicatorBuilder:
                          (final BuildContext context) =>
                              const Center(child: CircularProgressIndicator()),
                      noItemsFoundIndicatorBuilder:
                          (final BuildContext context) => Center(
                        child: Text(
                          'There\'s no data associated\nwith this entity',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      noMoreItemsIndicatorBuilder:
                          (final BuildContext context) => const SizedBox(),
                      itemBuilder: (final context, final item, final index) {
                        return EntityDataPaginatedListCard(entityData: item);
                      },
                    ),
                    separatorBuilder:
                        (final BuildContext context, final int index) =>
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

class EntityDataPaginatedListHeader extends StatelessWidget {
  final String entityType;

  const EntityDataPaginatedListHeader({
    super.key,
    required this.entityType,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$entityType ID',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Text(
          'Last updated',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}

class EntityDataPaginatedListCard extends StatelessWidget {
  final EntityData entityData;

  const EntityDataPaginatedListCard({
    super.key,
    required this.entityData,
  });

  @override
  Widget build(BuildContext context) {
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
            entityData.fhirId ?? '',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            entityData.lastUpdate?.toIso8601String() ?? '',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
