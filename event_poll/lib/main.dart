import 'package:event_poll/states/auth_state.dart';
import 'package:event_poll/ui/login_page.dart';
import 'package:event_poll/ui/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import '../ui/app_scaffold.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthState(),
      builder: ((_, __) => const App()),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Poll',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      supportedLocales: const [Locale('fr')],
      locale: const Locale('fr'),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      initialRoute: '/polls',
      routes: {
        '/polls': (context) => const AppScaffold(
              title: 'Événements',
              body: Placeholder(child: Center(child: Text('POLLS'))),
            ),
        '/polls/create': (context) => const AppScaffold(
              title: 'Ajouter un événement',
              body: Placeholder(child: Center(child: Text('POLLS_CREATE'))),
            ),
        '/polls/detail': (context) => const AppScaffold(
              title: 'Événement',
              body: Placeholder(child: Center(child: Text('POLLS_DETAIL'))),
            ),
        '/polls/update': (context) => const AppScaffold(
              title: 'Modifier un événement',
              body: Placeholder(child: Center(child: Text('POLLS_UPDATE'))),
            ),
        '/login': (context) => const AppScaffold(
              title: 'Connexion',
              body: LoginPage(),
            ),
        '/signup': (context) => const AppScaffold(
              title: 'Inscription',
              body: SignupPage(),
            ),
      },
    );
  }
}
