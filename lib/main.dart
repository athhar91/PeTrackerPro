import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pe_track/core/constants/app_constants.dart';
import 'package:pe_track/core/router/app_router.dart';
import 'package:pe_track/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
    );
  }
}
