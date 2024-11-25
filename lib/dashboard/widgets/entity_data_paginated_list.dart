import 'package:fhir/r4.dart';
import 'package:fhir_rest_client/fhir_rest_client.dart';
import 'package:fire_scribe/auth/cubit/fhir_server_connection_cubit.dart';
import 'package:fire_scribe/dashboard/cubit/dashboard_cubit.dart';
import 'package:fire_scribe/fhir_resource/fhir_resource_editor_bottom_sheet.dart';
import 'package:fire_scribe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

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
  const EntityDataPaginatedList({
    super.key,
  });

  @override
  State<EntityDataPaginatedList> createState() =>
      _EntityDataPaginatedListState();
}

class _EntityDataPaginatedListState extends State<EntityDataPaginatedList> {
  final pagingController = PagingController<int, EntityData>(firstPageKey: 0);
  String? entitySelected;

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

    final rawBundle =
        await BlocProvider.of<FhirServerConnectionCubit>(context).request(
      request: FhirRequest(
        operation: FhirRequestOperation.search,
        entityName: entitySelected!,
        parameters: {'_sort': '-_lastUpdated'},
      ),
    );
    if (rawBundle == null) {
      pagingController.appendLastPage([]);
      return;
    }
    final bundle = Bundle.fromJson(rawBundle);

    final entries = (bundle.entry ?? <BundleEntry>[])
        .where((entry) => entry.resource != null)
        .map(
          (entry) => EntityData(
            fhirId: entry.resource!.fhirId,
            lastUpdate: entry.resource!.meta?.lastUpdated,
            rawDataJson: entry.resource!.toJsonString(),
          ),
        )
        .toList();

    pagingController.appendLastPage(entries);
  }

  void updateExistingResource(final int index, final Resource resource) {
    setState(() {
      pagingController.itemList?.removeAt(index);
      pagingController.itemList?.insert(
        0,
        EntityData(
          fhirId: resource.fhirId,
          lastUpdate: resource.meta?.lastUpdated,
          rawDataJson: resource.toJsonString(),
        ),
      );
    });
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
                        return EntityDataPaginatedListCard(
                          entityData: item,
                          resourceWasUpdated: (resource) =>
                              updateExistingResource(
                            index,
                            resource,
                          ),
                        );
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

class EntityDataPaginatedListCard extends StatelessWidget {
  final EntityData entityData;
  final Function(Resource) resourceWasUpdated;

  const EntityDataPaginatedListCard({
    super.key,
    required this.entityData,
    required this.resourceWasUpdated,
  });

  Future<void> _showCodeEditor(final BuildContext context) async {
    final resource = await FhirResourceEditorBottonSheet.show(
      context,
      resource: Resource.fromJsonString(entityData.rawDataJson),
    );

    if (resource != null && resource.toJsonString() != entityData.rawDataJson) {
      resourceWasUpdated(resource);
    }
  }

  @override
  Widget build(BuildContext context) {
    final iso8601String = entityData.lastUpdate?.toIso8601String();
    final dateTime =
        iso8601String != null ? DateTime.parse(iso8601String) : null;

    return InkWell(
      onTap: () => _showCodeEditor(context),
      child: Container(
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
              dateTime != null
                  ? DateFormat.yMd().add_Hms().format(dateTime)
                  : '',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
