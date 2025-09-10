import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ember/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:ember/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'amplify_outputs.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized(); // required for sync setup

    await _configureAmplify(); // configure Amplify

    runApp(ProviderScope(child: const App()));
  } on AmplifyException catch (e) {
    runApp(
      ProviderScope(child: Text("Error configuring Amplify: ${e.message}")),
    );
  }
}

Future<void> _configureAmplify() async {
  try {
    await Amplify.addPlugins([
      AmplifyAuthCognito(),
      AmplifyAPI(
        options: APIPluginOptions(modelProvider: ModelProvider.instance),
      ),
    ]);
    await Amplify.configure(amplifyConfig);
    safePrint('Successfully configured');
  } on Exception catch (e) {
    safePrint('Error configuring Amplify: $e');
  }
}
