import 'package:flutter/material.dart';
import 'package:garden_app/enums/plant_type_enum.dart';
import 'package:garden_app/helpers/hive_db_helper.dart';
import 'package:garden_app/model/hive/plant_model.dart';
import 'package:garden_app/pages/add_plant_page.dart';
import 'package:garden_app/services/navigation_service.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class PlantsListPage extends StatefulWidget {
  PlantsListPage({Key? key}) : super(key: key);

  @override
  _PlantsListPageState createState() => _PlantsListPageState();
}

class _PlantsListPageState extends State<PlantsListPage> {
  TextEditingController _searchController = TextEditingController();
  List<PlantModel> _plants = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Garden'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() {
                _plants = HiveDbHelper.getPlants()!.values.toList().cast<PlantModel>();
                _plants =
                    _plants.where((item) => item.plantName.toLowerCase().startsWith(value.toLowerCase())).toList();
              }),
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)))),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<Box<PlantModel>>(
              valueListenable: HiveDbHelper.getPlants()!.listenable(),
              builder: (context, box, _) {
                if (_searchController.text.isEmpty) _plants = box.values.toList().cast<PlantModel>();

                if (_plants.length == 0) {
                  return Center(
                    child: Text('No plants'),
                  );
                } else
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 2,
                            );
                          },
                          primary: true,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _plants.length,
                          itemBuilder: (context, index) {
                            return _buildPlantTile(_plants[index], context);
                          },
                        ),
                      ),
                    ],
                  );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'child',
        elevation: 4.0,
        onPressed: () async {
          NavService.push(
              context,
              AddOrUpdatePlantPage(
                editMode: false,
              ));
        },
        label: Text('Add plant', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
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
  var formattedDate = DateFormat('yyyy-MM-dd').format(model.plantingDate);
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8, bottom: 4.0),
    child: Material(
      borderRadius: BorderRadius.circular(4),
      elevation: 4.0,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onTap: () => NavService.push(
            context,
            AddOrUpdatePlantPage(
              model: model,
              editMode: true,
            )),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.plantName[0].toUpperCase()} ${model.plantName[model.plantName.length - 1]}',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8),
                    Text(
                      model.plantName,
                      style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${PlantTypeEnumToString[model.plantType]!.toUpperCase()}',
                      style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Planting date: ' + formattedDate,
                      style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Image.asset(
                'assets/images/plant_icon.png',
                fit: BoxFit.cover,
                color: Theme.of(context).accentColor,
              )),
            ],
          ),
        ),
      ),
    ),
  );
}
