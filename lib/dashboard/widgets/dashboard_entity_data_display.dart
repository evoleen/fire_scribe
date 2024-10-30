import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:fhir_rest_client/fhir_rest_client.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class EntityData {
  final String? fhirId;
  final FhirInstant? lastUpdate;

  EntityData({
    this.fhirId,
    this.lastUpdate,
  });
}

class DashboardEntityDataDisplay extends StatefulWidget {
  final String entityType;
  final FhirRestClient fhirRestClient;
  static const int pageSize = 20;

  const DashboardEntityDataDisplay({
    super.key,
    required this.entityType,
    required this.fhirRestClient,
  });

  @override
  State<DashboardEntityDataDisplay> createState() =>
      _DashboardEntityDataDisplayState();
}

class _DashboardEntityDataDisplayState
    extends State<DashboardEntityDataDisplay> {
  PagingController<int, EntityData> pagingController =
      PagingController(firstPageKey: 0);
  String? searchOffset;
  CancelableOperation<void>? _searchOperation;
  Set<String> alreadyInListPatientIds = {};

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
    // var isCanceled = false;

    // Future<void> searchPatients() async {
    //   try {
    const entityName = 'Patient';
    final rawBundle = await widget.fhirRestClient.execute(
      request: FhirRequest(
        operation: FhirRequestOperation.search,
        entityName: entityName,
      ),
    );
    final bundle = Bundle.fromJson(rawBundle);

    final patients = (bundle.entry ?? <BundleEntry>[])
        .map((entry) {
          if (entry.resource?.resourceType?.name == entityName) {
            final patient = Patient.fromJson(entry.resource!.toJson());
            return EntityData(
              fhirId: patient.fhirId!,
              lastUpdate: patient.meta?.lastUpdated,
            );
          } else {
            return null;
          }
        })
        .whereNotNull()
        .toList();

    pagingController.appendLastPage(patients);

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
    return PagedListView<int, EntityData>.separated(
      pagingController: pagingController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 20),
      itemExtent: 80,
      builderDelegate: PagedChildBuilderDelegate<EntityData>(
        newPageProgressIndicatorBuilder: (final BuildContext context) =>
            const Center(child: CircularProgressIndicator()),
        noItemsFoundIndicatorBuilder: (final BuildContext context) =>
            const Padding(
          padding: EdgeInsets.only(top: 120),
          child: Center(
            child: Text('Empty'),
          ),
        ),
        noMoreItemsIndicatorBuilder: (final BuildContext context) =>
            const SizedBox(),
        itemBuilder: (final context, final item, final index) {
          return Row(
            children: [
              Text(item.fhirId ?? ''),
              SizedBox(width: 8),
              Text(
                item.lastUpdate?.toIso8601String() ?? '',
              ),
            ],
          );
        },
      ),
      separatorBuilder: (final BuildContext context, final int index) =>
          const SizedBox(height: 16),
    );
  }
}
