// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:azure_identity/azure_identity.dart';
import 'package:firearrow_admin_app/app_logger.dart';
import 'package:firearrow_admin_app/auth/azure_identity_provider_cubit.dart';
import 'package:firearrow_admin_app/connection/cubit/fhir_rest_client_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('foo', (WidgetTester tester) async {
    const url =
        'https://aeradevworkspace-aera-data.fhir.azurehealthcareapis.com/';
    final authCubit = AzureIdentityProviderCubit(
      defaultAzureCredential: DefaultAzureCredential(
        logger: AppLogger.instance.d,
      ),
    );
    await authCubit.signIn(AzureIdentityProviderCubitParams(serverUrl: url));

    final connectionCubit = FhirRestClientCubit();
    connectionCubit.connect(
      uri: Uri.parse(url),
      getToken: () async {
        final token = await authCubit.accessToken();
        AppLogger.instance.d('Bearer $token');
        if (token == null) {
          return null;
        }
        return 'Bearer $token';
      },
    );

    connectionCubit.state.when(
      connected: (client) async {
        // final repo = PatientGqlRepository(graphQLClient: client);
        // final patients = await repo.search();
        // print(patients);
      },
      disconnected: () {},
    );
  });
}
