import 'package:assignment/firebase_options.dart';
import 'package:assignment/presentation/splash_page.dart';
import 'package:assignment/provider/course_provider.dart';
import 'package:assignment/provider/home_navigation_provider.dart';
import 'package:assignment/provider/home_provider.dart';
import 'package:assignment/provider/login_provider.dart';
import 'package:assignment/provider/signup_provider.dart';
import 'package:assignment/provider/splash_provider.dart';
import 'package:assignment/utils/routes/routes.dart';
import 'package:assignment/utils/routes/routes_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SplashProvider()),
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => SignupProvider()),
      ChangeNotifierProvider(create: (_) => HomeNavigationProvider()),
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(create: (_) => CourseProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutesName.splashScreen,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
