import 'package:fhir/r4.dart';

extension ResourceX on Resource {
  /// Return and empty [Resource] type, based in https://github.com/fhir-fli/fhir/blob/main/lib/r4/resource/resource_from_json.dart
  static Resource factoryCreation(final String resourceType) {
    switch (resourceType) {
      case 'Account':
        return Account();
      case 'ActivityDefinition':
        return ActivityDefinition();
      case 'AdministrableProductDefinition':
        return AdministrableProductDefinition(
          routeOfAdministration: [],
        );
      case 'AdverseEvent':
        return AdverseEvent(
          subject: Reference(),
        );
      case 'AllergyIntolerance':
        return AllergyIntolerance(
          patient: Reference(),
        );
      case 'Appointment':
        return Appointment(
          participant: [],
        );
      case 'AppointmentResponse':
        return AppointmentResponse(
          appointment: Reference(),
        );
      case 'AuditEvent':
        return AuditEvent(
          type: Coding(),
          agent: [],
          source: AuditEventSource(
            observer: Reference(),
          ),
        );
      case 'Basic':
        return Basic(
          code: CodeableConcept(),
        );
      case 'Binary':
        return Binary();
      case 'BiologicallyDerivedProduct':
        return BiologicallyDerivedProduct();
      case 'BodyStructure':
        return BodyStructure(
          patient: Reference(),
        );
      case 'Bundle':
        return Bundle();
      case 'CapabilityStatement':
        return CapabilityStatement();
      case 'CarePlan':
        return CarePlan(
          subject: Reference(),
        );
      case 'CareTeam':
        return CareTeam();
      case 'CatalogEntry':
        return CatalogEntry(
          referencedItem: Reference(),
        );
      case 'ChargeItem':
        return ChargeItem(
          code: CodeableConcept(),
          subject: Reference(),
        );
      case 'ChargeItemDefinition':
        return ChargeItemDefinition();
      case 'Citation':
        return Citation();
      case 'Claim':
        return Claim(
          type: CodeableConcept(),
          patient: Reference(),
          provider: Reference(),
          priority: CodeableConcept(),
          insurance: [],
        );
      case 'ClaimResponse':
        return ClaimResponse(
          type: CodeableConcept(),
          patient: Reference(),
          insurer: Reference(),
        );
      case 'ClinicalImpression':
        return ClinicalImpression(
          subject: Reference(),
        );
      case 'ClinicalUseDefinition':
        return ClinicalUseDefinition();
      case 'CodeSystem':
        return CodeSystem();
      case 'Communication':
        return Communication();
      case 'CommunicationRequest':
        return CommunicationRequest();
      case 'CompartmentDefinition':
        return CompartmentDefinition();
      case 'Composition':
        return Composition(
          type: CodeableConcept(),
          author: [],
        );
      case 'ConceptMap':
        return ConceptMap();
      case 'Condition':
        return Condition(
          subject: Reference(),
        );
      case 'Consent':
        return Consent(
          scope: CodeableConcept(),
          category: [],
        );
      case 'Contract':
        return Contract();
      case 'Coverage':
        return Coverage(
          beneficiary: Reference(),
          payor: [],
        );
      case 'CoverageEligibilityRequest':
        return CoverageEligibilityRequest(
          patient: Reference(),
          insurer: Reference(),
        );
      case 'CoverageEligibilityResponse':
        return CoverageEligibilityResponse(
          patient: Reference(),
          request: Reference(),
          insurer: Reference(),
        );
      case 'DetectedIssue':
        return DetectedIssue();
      case 'Device':
        return Device();
      case 'DeviceDefinition':
        return DeviceDefinition();
      case 'DeviceMetric':
        return DeviceMetric(
          type: CodeableConcept(),
        );
      case 'DeviceRequest':
        return DeviceRequest(
          subject: Reference(),
        );
      case 'DeviceUseStatement':
        return DeviceUseStatement(
          subject: Reference(),
          device: Reference(),
        );
      case 'DiagnosticReport':
        return DiagnosticReport(
          code: CodeableConcept(),
        );
      case 'DocumentManifest':
        return DocumentManifest(
          content: [],
        );
      case 'DocumentReference':
        return DocumentReference(
          content: [],
        );
      case 'Encounter':
        return Encounter(
          class_: Coding(),
        );
      case 'Endpoint':
        return FhirEndpoint(
          connectionType: Coding(),
          payloadType: [],
        );
      case 'EnrollmentRequest':
        return EnrollmentRequest();
      case 'EnrollmentResponse':
        return EnrollmentResponse();
      case 'EpisodeOfCare':
        return EpisodeOfCare(
          patient: Reference(),
        );
      case 'EventDefinition':
        return EventDefinition(
          trigger: [],
        );
      case 'Evidence':
        return Evidence(
          variableDefinition: [],
        );
      case 'EvidenceReport':
        return EvidenceReport(
          subject: EvidenceReportSubject(),
        );
      case 'EvidenceVariable':
        return EvidenceVariable(
          characteristic: [],
        );
      case 'ExampleScenario':
        return ExampleScenario();
      case 'ExplanationOfBenefit':
        return ExplanationOfBenefit(
          type: CodeableConcept(),
          patient: Reference(),
          provider: Reference(),
          insurer: Reference(),
          insurance: [],
        );
      case 'FamilyMemberHistory':
        return FamilyMemberHistory(
          patient: Reference(),
          relationship: CodeableConcept(),
        );
      case 'Flag':
        return Flag(
          code: CodeableConcept(),
          subject: Reference(),
        );
      case 'Goal':
        return Goal(
          description: CodeableConcept(),
          subject: Reference(),
        );
      case 'GraphDefinition':
        return GraphDefinition();
      case 'Group':
        return FhirGroup();
      case 'GuidanceResponse':
        return GuidanceResponse();
      case 'HealthcareService':
        return HealthcareService();
      case 'ImagingStudy':
        return ImagingStudy(
          subject: Reference(),
        );
      case 'Immunization':
        return Immunization(
          vaccineCode: CodeableConcept(),
          patient: Reference(),
        );
      case 'ImmunizationEvaluation':
        return ImmunizationEvaluation(
          patient: Reference(),
          targetDisease: CodeableConcept(),
          immunizationEvent: Reference(),
          doseStatus: CodeableConcept(),
        );
      case 'ImmunizationRecommendation':
        return ImmunizationRecommendation(
          patient: Reference(),
          recommendation: [],
        );
      case 'ImplementationGuide':
        return ImplementationGuide();
      case 'Ingredient':
        return Ingredient(
          role: CodeableConcept(),
          substance: IngredientSubstance(
            code: CodeableReference(),
          ),
        );
      case 'InsurancePlan':
        return InsurancePlan();
      case 'Invoice':
        return Invoice();
      case 'Library':
        return Library(
          type: CodeableConcept(),
        );
      case 'Linkage':
        return Linkage(
          item: [],
        );
      case 'List':
        return FhirList();
      case 'Location':
        return Location();
      case 'ManufacturedItemDefinition':
        return ManufacturedItemDefinition(
          manufacturedDoseForm: CodeableConcept(),
        );
      case 'Measure':
        return Measure();
      case 'MeasureReport':
        return MeasureReport(
          measure: FhirCanonical(''),
          period: Period(),
        );
      case 'Media':
        return Media(
          content: Attachment(),
        );
      case 'Medication':
        return Medication();
      case 'MedicationAdministration':
        return MedicationAdministration(
          subject: Reference(),
        );
      case 'MedicationDispense':
        return MedicationDispense();
      case 'MedicationKnowledge':
        return MedicationKnowledge();
      case 'MedicationRequest':
        return MedicationRequest(
          subject: Reference(),
        );
      case 'MedicationStatement':
        return MedicationStatement(
          subject: Reference(),
        );
      case 'MedicinalProductDefinition':
        return MedicinalProductDefinition(
          name: [],
        );
      case 'MessageDefinition':
        return MessageDefinition();
      case 'MessageHeader':
        return MessageHeader(
          source: MessageHeaderSource(),
        );
      case 'MolecularSequence':
        return MolecularSequence();
      case 'NamingSystem':
        return NamingSystem(
          uniqueId: [],
        );
      case 'NutritionOrder':
        return NutritionOrder(
          patient: Reference(),
        );
      case 'NutritionProduct':
        return NutritionProduct();
      case 'Observation':
        return Observation(
          code: CodeableConcept(),
        );
      case 'ObservationDefinition':
        return ObservationDefinition(
          code: CodeableConcept(),
        );
      case 'OperationDefinition':
        return OperationDefinition();
      case 'OperationOutcome':
        return OperationOutcome(
          issue: [],
        );
      case 'Organization':
        return Organization();
      case 'OrganizationAffiliation':
        return OrganizationAffiliation();
      case 'PackagedProductDefinition':
        return PackagedProductDefinition();
      case 'Parameters':
        return Parameters();
      case 'Patient':
        return Patient();
      case 'PaymentNotice':
        return PaymentNotice(
          payment: Reference(),
          recipient: Reference(),
          amount: Money(),
        );
      case 'PaymentReconciliation':
        return PaymentReconciliation(
          paymentAmount: Money(),
        );
      case 'Person':
        return Person();
      case 'PlanDefinition':
        return PlanDefinition();
      case 'Practitioner':
        return Practitioner();
      case 'PractitionerRole':
        return PractitionerRole();
      case 'Procedure':
        return Procedure(
          subject: Reference(),
        );
      case 'Provenance':
        return Provenance(
          agent: [],
          target: [],
        );
      case 'Questionnaire':
        return Questionnaire();
      case 'QuestionnaireResponse':
        return QuestionnaireResponse();
      case 'RegulatedAuthorization':
        return RegulatedAuthorization();
      case 'RelatedPerson':
        return RelatedPerson(
          patient: Reference(),
        );
      case 'RequestGroup':
        return RequestGroup();
      case 'ResearchDefinition':
        return ResearchDefinition(
          population: Reference(),
        );
      case 'ResearchElementDefinition':
        return ResearchElementDefinition(
          characteristic: [],
        );
      case 'ResearchStudy':
        return ResearchStudy();
      case 'ResearchSubject':
        return ResearchSubject(
          individual: Reference(),
          study: Reference(),
        );
      case 'RiskAssessment':
        return RiskAssessment(
          subject: Reference(),
        );
      case 'Schedule':
        return Schedule(
          actor: [],
        );
      case 'SearchParameter':
        return SearchParameter();
      case 'ServiceRequest':
        return ServiceRequest(
          subject: Reference(),
        );
      case 'Slot':
        return Slot(
          schedule: Reference(),
        );
      case 'Specimen':
        return Specimen();
      case 'SpecimenDefinition':
        return SpecimenDefinition();
      case 'StructureDefinition':
        return StructureDefinition();
      case 'StructureMap':
        return StructureMap(
          group: [],
        );
      case 'Subscription':
        return Subscription(
          channel: SubscriptionChannel(),
        );
      case 'SubscriptionStatus':
        return SubscriptionStatus(
          subscription: Reference(),
        );
      case 'SubscriptionTopic':
        return SubscriptionTopic();
      case 'Substance':
        return Substance(
          code: CodeableConcept(),
        );
      case 'SubstanceDefinition':
        return SubstanceDefinition();
      case 'SupplyDelivery':
        return SupplyDelivery();
      case 'SupplyRequest':
        return SupplyRequest(
          quantity: Quantity(),
        );
      case 'Task':
        return Task();
      case 'TerminologyCapabilities':
        return TerminologyCapabilities();
      case 'TestReport':
        return TestReport(
          testScript: Reference(),
        );
      case 'TestScript':
        return TestScript();
      case 'ValueSet':
        return ValueSet();
      case 'VerificationResult':
        return VerificationResult();
      case 'VisionPrescription':
        return VisionPrescription(
          lensSpecification: [],
          patient: Reference(),
          prescriber: Reference(),
        );
      default:
        throw UnsupportedError(
            "You have passed Resource.fromJson a type doesn't exist or is null. "
            'In this case, the resourceType is $resourceType.');
    }
  }
}
