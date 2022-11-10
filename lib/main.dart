import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'homepage/homepage.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(formArray: formsState.form,),
    );
  }
}
