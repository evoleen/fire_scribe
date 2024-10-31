import 'package:flutter/material.dart';

class DraggableBottomSheet extends StatefulWidget {
  final Widget? Function(BuildContext)? buildDraggableArea;
  final Widget Function(BuildContext) buildContent;

  const DraggableBottomSheet({
    super.key,
    this.buildDraggableArea,
    required this.buildContent,
  });

  static Future<dynamic> show(
    final BuildContext context, {
    final Widget? Function(BuildContext)? buildDraggableArea,
    required final Widget Function(BuildContext) buildContent,
  }) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => DraggableBottomSheet(
          buildContent: (p0) => buildContent(p0),
          buildDraggableArea: (p0) =>
              buildDraggableArea != null ? buildDraggableArea(p0) : null,
        ),
      );

  @override
  State createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  var currentChildSize = 0.5;
  final minChildSize = 0.3;
  final maxChildSize = 0.8;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: currentChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              if (widget.buildDraggableArea != null)
                GestureDetector(
                  onVerticalDragUpdate: (details) {
                    setState(() {
                      currentChildSize = (currentChildSize -
                              details.primaryDelta! /
                                  MediaQuery.of(context).size.height)
                          .clamp(minChildSize, maxChildSize);
                    });
                  },
                  child: widget.buildDraggableArea!(context),
                ),
              Expanded(
                child: widget.buildContent(context),
              ),
            ],
          ),
        );
      },
    );
  }
}

class EntityEditorDraggableHeader extends StatelessWidget {
  const EntityEditorDraggableHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: Icon(Icons.close),
                ),
                SizedBox(width: 4),
                Text(
                  'KDSIW32982JKDSDSD',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            FilledButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                child: Text(
                  'Save Changes',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
