import 'package:autism/logic/services/sized_config.dart';
import 'package:autism/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://sngondoxycdwehebwgit.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNuZ29uZG94eWNkd2VoZWJ3Z2l0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTkzOTQzMjMsImV4cCI6MjA3NDk3MDMyM30.nG1FqvraSG-z0AFu6gOM6GdT_J2iu7oqMBBQXpQryuk",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.black,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
