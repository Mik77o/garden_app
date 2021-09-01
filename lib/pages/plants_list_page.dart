import 'package:flutter/material.dart';

class PlantsListPage extends StatefulWidget {
  PlantsListPage({Key? key}) : super(key: key);

  @override
  _PlantsListPageState createState() => _PlantsListPageState();
}

class _PlantsListPageState extends State<PlantsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista roślin'),
      ),
      body: Center(child: Text('Lista roślin')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add plant',
        child: Icon(Icons.add),
      ),
    );
  }
}
