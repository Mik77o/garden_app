import 'package:flutter/material.dart';
import 'package:garden_app/pages/plants_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Plants App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PlantsListPage());
  }
}
