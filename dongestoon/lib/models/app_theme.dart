import 'package:flutter/material.dart';

ThemeData appTheme(){
  Color homeTopBackColor = Color.fromARGB(255, 44, 41, 51);
  Color homeBottomBackColor = Color.fromARGB(255, 29, 27, 32);
  return ThemeData(
    colorScheme: ColorScheme.dark(primary: homeTopBackColor,secondary: homeBottomBackColor),
    primaryColor: const Color.fromARGB(255, 29, 27, 32),

    useMaterial3: true,
  );
}