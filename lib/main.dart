import 'package:autism/logic/cubit/add_child/cubit/children_cubit.dart';
import 'package:autism/logic/services/sized_config.dart';
import 'package:autism/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // الوضع العمودي فقط
  ]);

  await Supabase.initialize(
    url: "https://rayjwbhokltsbgxtnzpv.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJheWp3Ymhva2x0c2JneHRuenB2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTkyMjUyOTYsImV4cCI6MjA3NDgwMTI5Nn0.nAXudUa5usDI0HgZgn_xe3bMJZHKTlnZxAx4ZqQhoK8",
  );
  runApp(
    BlocProvider(create: (context) => ChildrenCubit(), child: const MyApp()),
  );
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
