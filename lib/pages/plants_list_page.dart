import 'package:flutter/material.dart';
import 'package:garden_app/enums/plant_type_enum.dart';
import 'package:garden_app/helpers/hive_db_helper.dart';
import 'package:garden_app/model/hive/plant_model.dart';
import 'package:garden_app/pages/add_plant_page.dart';
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
  List<PlantModel> _paginatedList = [];

  int _present = 0;
  int _forOnePage = 10;

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
          _buildHeader(),
          _buildListViewWithValueListenable(),
        ],
      ),
    );
  }

  Expanded _buildListViewWithValueListenable() {
    return Expanded(
      child: ValueListenableBuilder<Box<PlantModel>>(
        valueListenable: HiveDbHelper.getPlants()!.listenable(),
        builder: (context, box, _) {
          _plants = box.values.toList().cast<PlantModel>();
          _plants.sort((b, a) => a.plantingDate.compareTo(b.plantingDate));
          if (_present == 0) {
            if (_plants.length <= 10) {
              _paginatedList.addAll(_plants.getRange(_present, _plants.length));
            } else
              _paginatedList.addAll(_plants.getRange(_present, _present + _forOnePage));
          }

          _present = _present + _forOnePage;

          if (_plants.length == 0) {
            return Center(
              child: Text('No plants', style: TextStyle(color: Colors.black54, fontSize: 16)),
            );
          } else
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: (_present <= _plants.length) ? _paginatedList.length + 1 : _paginatedList.length,
                    itemBuilder: (context, index) {
                      return index == _paginatedList.length
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                              child: ElevatedButton.icon(
                                  onPressed: () => {
                                        setState(() {
                                          if ((_present + _forOnePage) > _plants.length) {
                                            _paginatedList.addAll(_plants.getRange(_present, _plants.length));
                                          } else {
                                            _paginatedList.addAll(_plants.getRange(_present, _present + _forOnePage));
                                          }
                                          _present = _present + _forOnePage;
                                        })
                                      },
                                  icon: Icon(Icons.arrow_downward_outlined),
                                  label: Text('Load more'.toUpperCase())),
                            )
                          : _buildPlantTile(_paginatedList[index], context);
                    },
                  ),
                ),
              ],
            );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() {
                _paginatedList =
                    _plants.where((item) => item.plantName.toLowerCase().startsWith(value.toLowerCase())).toList();
                if (value.isEmpty) {
                  _paginatedList.clear();
                  _plants.clear();
                  _present = 0;
                }
              }),
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)))),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ElevatedButton(
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddOrUpdatePlantPage(editMode: false)))
                    .then((value) {
                  setState(() {
                    _paginatedList.clear();
                    _plants.clear();
                    _present = 0;
                  });
                });
              },
              child: Text('Add plant'.toUpperCase())),
        ),
      ],
    );
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
            borderRadius: BorderRadius.circular(4),
          ),
          onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddOrUpdatePlantPage(model: model, editMode: true)))
              .then((value) {
            setState(() {
              _paginatedList.clear();
              _plants.clear();
              _present = 0;
            });
          }),
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
                        '${model.plantName[0].toUpperCase()} ${model.plantName[model.plantName.length - 1].toUpperCase()}',
                        style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Text(model.plantName.toUpperCase(),
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      SizedBox(height: 8),
                      Text(
                        '${PlantTypeEnumToString[model.plantType]!.toUpperCase()}',
                        style: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Planting date  '.toUpperCase(),
                            style: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            formattedDate,
                            style: TextStyle(
                                color: Theme.of(context).buttonColor, fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    'assets/images/plant_icon.png',
                    height: 64,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
