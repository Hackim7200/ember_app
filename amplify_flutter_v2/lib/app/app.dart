import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:ember/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:ember/app/app_shell.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // put state management here

    return Authenticator(
      // Wraps app with built-in auth UI
      child: MaterialApp(
        title: 'Boilerplate',
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        builder: Authenticator.builder(), // Builds login/signup flows if needed
        home: AppShell(),
      ),
    );
  }
}
