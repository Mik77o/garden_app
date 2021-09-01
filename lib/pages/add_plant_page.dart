import 'package:flutter/material.dart';
import 'package:garden_app/enums/plant_type_enum.dart';
import 'package:garden_app/helpers/hive_db_helper.dart';
import 'package:garden_app/helpers/input_decoration_helper.dart';
import 'package:garden_app/model/hive/plant_types_model.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

class AddPlantPage extends StatefulWidget {
  AddPlantPage({Key? key}) : super(key: key);

  @override
  _AddPlantPageState createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  TextEditingController _plantNameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  final _globalKey = GlobalKey<FormState>();
  Box<PlantTypeModel>? plantTypesFromHive;
  List<PlantTypeEnum> plantTypes = [];
  PlantTypeEnum value = PlantTypeEnum.Alpines;

  @override
  void initState() {
    super.initState();
    plantTypesFromHive = Hive.box<PlantTypeModel>('plantTypes');
    if (plantTypesFromHive != null && plantTypesFromHive!.isEmpty) {
      plantTypesFromHive!.add(PlantTypeModel(typesList: PlantTypeEnum.values));

      for (var i in plantTypesFromHive!.values.first.typesList) {
        plantTypes.add(i);
      }
    } else {
      for (var t in plantTypesFromHive!.values.first.typesList) {
        plantTypes.add(t);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        title: Text('Add plant'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Form(
            key: _globalKey,
            child: Material(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildModelEntry(),
                    SizedBox(
                      height: 16,
                    ),
                    _buildPlantTypesDropDownButton(),
                    SizedBox(
                      height: 16,
                    ),
                    _buildDatetimePlantingTextField(),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).buttonColor),
                        child: Text('Add plant'.toUpperCase()),
                        onPressed: () async {
                          HiveDbHelper.addPlant("Test", value, DateTime.now());
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlantTypesDropDownButton() {
    return DropdownButtonFormField<PlantTypeEnum>(
      value: value,
      decoration: InputDecorationFormatter.getInputDecoration(context,
          labelText: "Choose plant type"),
      style: TextStyle(color: Colors.black54, fontSize: 16),
      icon: const Icon(Icons.arrow_downward_outlined),
      iconSize: 24,
      elevation: 16,
      onChanged: (PlantTypeEnum? newValue) {
        setState(() {
          value = newValue!;
        });
      },
      items: plantTypes
          .map<DropdownMenuItem<PlantTypeEnum>>((PlantTypeEnum value) {
        return DropdownMenuItem<PlantTypeEnum>(
            value: value, child: Text(PlantTypeEnumToString[value]!));
      }).toList(),
    );
  }

  Widget _buildModelEntry() {
    return TextFormField(
      controller: _plantNameController,
      style: TextStyle(color: Colors.black54, fontSize: 16),
      cursorColor: Theme.of(context).accentColor,
      keyboardType: TextInputType.text,
      decoration: InputDecorationFormatter.getInputDecoration(context,
          labelText: "Plant name"),
      validator: (model) {
        return model?.isEmpty == true ? "Add plant name" : null;
      },
    );
  }

  Widget _buildDatetimePlantingTextField() {
    final _format = DateFormat("yyyy-MM-dd");
    return DateTimeField(
      resetIcon: null,
      controller: _dateController,
      style: TextStyle(color: Colors.black54, fontSize: 16),
      validator: (content) {
        if (content == null) {
          return "Add date";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Planting date",
        hintText: 'Planting date',
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
      format: _format,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime.now());
      },
    );
  }
}
