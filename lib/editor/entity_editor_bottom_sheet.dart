import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_editor_flutter/json_editor_flutter.dart';

class EntityEditorBottonSheet extends StatefulWidget {
  const EntityEditorBottonSheet({
    super.key,
  });

  static Future<dynamic> show(final BuildContext context) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => EntityEditorBottonSheet(),
      );

  @override
  State createState() => _EntityEditorBottonSheetState();
}

class _EntityEditorBottonSheetState extends State<EntityEditorBottonSheet> {
  var currentChildSize = 0.8;
  final minChildSize = 0.3;
  final maxChildSize = 0.8;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: currentChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  setState(() {
                    currentChildSize = (currentChildSize -
                            details.primaryDelta! /
                                MediaQuery.of(context).size.height)
                        .clamp(minChildSize, maxChildSize);
                  });
                },
                child: EntityEditorDraggableHeader(),
              ),
              Expanded(
                child: JsonEditor(
                  json: jsonEncode(patientJson),
                  onChanged: (data) {
                    print(data);
                  },
                ),
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
