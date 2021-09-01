import 'package:flutter/material.dart';
import 'package:garden_app/helpers/hive_db_helper.dart';
import 'package:garden_app/model/hive/plant_model.dart';
import 'package:garden_app/pages/add_plant_page.dart';
import 'package:garden_app/services/navigation_service.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PlantsListPage extends StatefulWidget {
  PlantsListPage({Key? key}) : super(key: key);

  @override
  _PlantsListPageState createState() => _PlantsListPageState();
}

class _PlantsListPageState extends State<PlantsListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Hive.box<PlantModel>('plants');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Garden'),
      ),
      body: ValueListenableBuilder<Box<PlantModel>>(
        valueListenable: HiveDbHelper.getPlants()!.listenable(),
        builder: (context, box, _) {
          final plants = box.values.toList().cast<PlantModel>();
          if (plants.length == 0) {
            return Center(
              child: Text('Brak roślin'),
            );
          } else
            return ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 2,
                );
              },
              primary: true,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: plants.length,
              itemBuilder: (context, index) {
                return _buildPlantTile(plants[index], context);
              },
            );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'child',
        elevation: 4.0,
        onPressed: () async {
          NavService.push(context, AddPlantPage());
        },
        label: Text('Add plant',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        icon: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}

Widget _buildPlantTile(PlantModel model, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8, bottom: 4.0),
    child: Material(
      color: Theme.of(context).accentColor,
      borderRadius: BorderRadius.circular(4),
      elevation: 2.0,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onTap: () => NavService.push(context, AddPlantPage()),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.plantName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    ),
  );
}
