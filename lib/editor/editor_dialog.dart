import 'package:firearrow_admin_app/editor/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';

class BottomDialogExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Dialog Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            DraggableBottomSheet.show(
              context,
              buildContent: (context) => IgnorePointer(
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: const [
                    Text(
                      'This is a bottom dialog',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'You can drag to resize this dialog only from the top bar.',
                      style: TextStyle(fontSize: 16),
                    ),
                    // Additional content
                  ],
                ),
              ),
              buildDraggableArea: (context) => EntityEditorDraggableHeader(),
            );
          },
          child: Text('Show Bottom Dialog'),
        ),
      ),
    );
  }
}

class EditorDialog extends StatelessWidget {
  EditorDialog._();

  static show() {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
