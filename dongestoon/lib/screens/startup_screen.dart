import 'package:dongestoon/block/home/home_cubit.dart';
import 'package:dongestoon/block/startup/startup_cubit.dart';
import 'package:dongestoon/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartUpScreen extends StatefulWidget {
  const StartUpScreen({super.key});

  @override
  State<StartUpScreen> createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartupCubit, StartupState>(
        builder: (BuildContext context, state) {
      if (state is StartUpLoading) {
        return loadingView(context);
      }
      if (state is StartUpLoginApproved) {
        return loginApproved(state.token);
      }
      if (state is StartUpLoginDisapproved) {
        return Container(
          color: Colors.red,
        );
      } else {
        return loadingView(context);
      }
    });
  }
  Widget loginApproved(String token){
    return BlocProvider(create: (context) => HomeCubit()..fetchUserData(),child: const HomeScreen(),);
  }
  Widget loginDisapproved(String token){
    return BlocProvider(create: (context) => HomeCubit()..fetchUserData(),child: const HomeScreen(),);
  }

  Widget loadingView(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(child: const CircularProgressIndicator()),
    );
  }
}
