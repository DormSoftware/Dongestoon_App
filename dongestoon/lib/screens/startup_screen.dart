import 'package:dongestoon/block/home/home_cubit.dart';
import 'package:dongestoon/block/login/login_cubit.dart';
import 'package:dongestoon/block/startup/startup_cubit.dart';
import 'package:dongestoon/screens/home_screen.dart';
import 'package:dongestoon/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartUpScreen extends StatefulWidget {
  const StartUpScreen({super.key});

  @override
  State<StartUpScreen> createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> {
  Widget? mainContent;

  @override
  Widget build(BuildContext context) {
    return BlocListener<StartupCubit, StartupState>(
      listener: (BuildContext context, state) {
        if (state is StartUpLoading) {
          setState(() {
            mainContent = loadingView(context);
          });
        }
        if (state is StartUpLoginApproved) {
          setState(() {
            mainContent = loginApproved(state.token);
          });
        }
        if (state is StartUpLoginDisapproved) {
          setState(() {
            mainContent = loginApproved("");
          });
        } else {
          loadingView(context);
        }
      },
      child: mainContent ?? loadingView(context),
    );
  }

  Widget loginApproved(String token) {
    return BlocProvider(
      create: (context) => HomeCubit()..fetchUserData(token),
      child: const HomeScreen(),
    );
  }

  Widget loginDisapproved() {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const LoginScreen(),
    );
  }

  Widget loadingView(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
