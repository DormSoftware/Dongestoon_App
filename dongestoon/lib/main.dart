import 'package:dongestoon/block/startup/startup_cubit.dart';
import 'package:dongestoon/models/app_theme.dart';
import 'package:dongestoon/screens/startup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: BlocProvider(
        create: (context) => StartupCubit()..checkUserIsLogged(context),
        child:  const StartUpScreen(),
      ),
    );
  }
}
