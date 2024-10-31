import 'dart:convert';

import 'package:firearrow_admin_app/editor/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:json_editor_flutter/json_editor_flutter.dart';

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
              buildContent: (context) => JsonEditor(
                json: jsonEncode(patientJson),
                onChanged: (data) {
                  print(data);
                },
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

final patientJson = {
  "resourceType": "Patient",
  "id": "123456",
  "identifier": [
    {
      "use": "usual",
      "type": {
        "coding": [
          {
            "system": "http://terminology.hl7.org/CodeSystem/v2-0203",
            "code": "MR",
            "display": "Medical Record Number"
          }
        ]
      },
      "system": "http://hospital.smarthealth.org",
      "value": "MR123456"
    }
  ],
  "active": true,
  "name": [
    {
      "use": "official",
      "family": "Doe",
      "given": ["John", "A"]
    },
    {
      "use": "nickname",
      "given": ["Johnny"]
    }
  ],
  "telecom": [
    {"system": "phone", "value": "+1-555-555-1234", "use": "home"},
    {"system": "email", "value": "john.doe@example.com", "use": "work"}
  ],
  "gender": "male",
  "birthDate": "1985-03-15",
  "address": [
    {
      "use": "home",
      "line": ["123 Main St", "Apt 4B"],
      "city": "Metropolis",
      "state": "NY",
      "postalCode": "10001",
      "country": "USA"
    }
  ],
  "maritalStatus": {
    "coding": [
      {
        "system": "http://terminology.hl7.org/CodeSystem/v3-MaritalStatus",
        "code": "M",
        "display": "Married"
      }
    ]
  },
  "contact": [
    {
      "relationship": [
        {
          "coding": [
            {
              "system": "http://terminology.hl7.org/CodeSystem/v2-0131",
              "code": "N",
              "display": "Next of Kin"
            }
          ]
        }
      ],
      "name": {
        "family": "Doe",
        "given": ["Jane"]
      },
      "telecom": [
        {"system": "phone", "value": "+1-555-555-5678", "use": "mobile"}
      ],
      "address": {
        "line": ["123 Main St", "Apt 4B"],
        "city": "Metropolis",
        "state": "NY",
        "postalCode": "10001",
        "country": "USA"
      },
      "gender": "female"
    }
  ],
  "communication": [
    {
      "language": {
        "coding": [
          {"system": "urn:ietf:bcp:47", "code": "en", "display": "English"}
        ]
      },
      "preferred": true
    }
  ]
};
