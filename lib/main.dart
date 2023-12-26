import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webkul_task/provider/dashboard_provider.dart';
import 'package:webkul_task/provider/login_provider.dart';
import 'package:webkul_task/provider/signup_provider.dart';
import 'package:webkul_task/views/dashboard/dashboard.dart';
import 'package:webkul_task/views/login/login_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
            create: (context) => LoginProvider()),
        ChangeNotifierProvider<SignupProvider>(
            create: (context) => SignupProvider()),
        ChangeNotifierProvider<DashBoardProvider>(
            create: (context) => DashBoardProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          '/home': (context) => const Dashboard(),
        },
        home: const Login(),
      ),
    );
  }
}
