import 'package:flutter/material.dart';
// import 'package:appwrite/appwrite.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ridebud/services/appwrite_services/appwrite_service.dart';

import 'package:ridebud/services/screens/homeScreen/home_screen.dart';
import 'package:ridebud/services/screens/UserAuth/intro_screen.dart';

import 'package:ridebud/services/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RideBud',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff1a1720),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xff2e4d4a),
        ),
      ),
      home: ref.watch(currentUserAccountProvider).when(
            data: (user) {
              if (user != null) {
                return HomeScreen(user.$id);
              }
              return const IntroScreen();
            },
            error: (error, st) => const IntroScreen(),
            loading: () => const SplashScreen(),
          ),
    );
  }
}
