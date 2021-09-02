import 'package:flutter/material.dart';
import 'package:garden_app/enums/plant_type_enum.dart';
import 'package:garden_app/helpers/hive_db_helper.dart';
import 'package:garden_app/helpers/input_decoration_helper.dart';
import 'package:garden_app/model/hive/plant_model.dart';
import 'package:garden_app/model/hive/plant_types_model.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:garden_app/services/navigation_service.dart';
import 'package:garden_app/services/toast_service.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

class AddPlantPage extends StatefulWidget {
  AddPlantPage({Key? key, this.model, required this.editMode}) : super(key: key);

  final PlantModel? model;
  final bool editMode;

  @override
  _AddPlantPageState createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  TextEditingController _plantNameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  final _globalKey = GlobalKey<FormState>();
  Box<PlantTypeModel>? _plantTypesFromHive;
  List<PlantTypeEnum> _plantTypes = [];
  PlantTypeEnum _currentPlantTypeValue = PlantTypeEnum.Alpines;

  @override
  void initState() {
    super.initState();
    if (widget.editMode == true && widget.model != null) {
      _plantNameController.text = widget.model!.plantName;
      _dateController.text = DateFormat('yyyy-MM-dd').format(widget.model!.plantingDate);
      _currentPlantTypeValue = widget.model!.plantType;
    }

    _plantTypesFromHive = HiveDbHelper.getPlantTypes();
    if (_plantTypesFromHive != null && _plantTypesFromHive!.isEmpty) {
      HiveDbHelper.addPlantTypes(_plantTypesFromHive!);

      for (var i in _plantTypesFromHive!.values.first.typesList) {
        _plantTypes.add(i);
      }
    } else {
      for (var t in _plantTypesFromHive!.values.first.typesList) {
        _plantTypes.add(t);
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
        title: widget.editMode == true ? Text('Edit plant') : Text('Add plant'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/plant_icon.png',
                height: 128,
                color: Theme.of(context).accentColor,
              ),
            ),
            Container(
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
                            style: ElevatedButton.styleFrom(primary: Theme.of(context).buttonColor),
                            child: widget.editMode == true
                                ? Text('Edit plant'.toUpperCase())
                                : Text('Add plant'.toUpperCase()),
                            onPressed: () async {
                              if (_globalKey.currentState?.validate() == true) {
                                if (widget.editMode == false)
                                  try {
                                    HiveDbHelper.addPlant(_plantNameController.text, _currentPlantTypeValue,
                                        DateTime.tryParse(_dateController.text) ?? DateTime.now());
                                    ToastService.show(context, "Plant successfully added!");
                                    NavService.pop(context);
                                  } catch (e) {
                                    ToastService.show(context, "Something went wrong...");
                                  }
                                else {
                                  try {
                                    if (widget.model != null) {
                                      HiveDbHelper.editPlant(
                                          widget.model!,
                                          _plantNameController.text,
                                          _currentPlantTypeValue,
                                          DateTime.tryParse(_dateController.text) ?? DateTime.now());
                                      ToastService.show(
                                          context, "Plant ${widget.model!.plantName} successfully edited!");
                                      NavService.pop(context);
                                    }
                                  } catch (e) {
                                    ToastService.show(context, "Something went wrong...");
                                  }
                                }
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantTypesDropDownButton() {
    return DropdownButtonFormField<PlantTypeEnum>(
      value: _currentPlantTypeValue,
      decoration: InputDecorationFormatter.getInputDecoration(context, labelText: "Choose plant type"),
      style: TextStyle(color: Colors.black54, fontSize: 16),
      icon: const Icon(Icons.arrow_downward_outlined),
      iconSize: 24,
      elevation: 16,
      onChanged: (PlantTypeEnum? newValue) {
        setState(() {
          _currentPlantTypeValue = newValue!;
        });
      },
      items: _plantTypes.map<DropdownMenuItem<PlantTypeEnum>>((PlantTypeEnum value) {
        return DropdownMenuItem<PlantTypeEnum>(value: value, child: Text(PlantTypeEnumToString[value]!));
      }).toList(),
    );
  }

  Widget _buildModelEntry() {
    return TextFormField(
      controller: _plantNameController,
      style: TextStyle(color: Colors.black54, fontSize: 16),
      cursorColor: Theme.of(context).accentColor,
      keyboardType: TextInputType.text,
      decoration: InputDecorationFormatter.getInputDecoration(context, labelText: "Plant name"),
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
        if (widget.editMode == true) {
          content = DateTime.tryParse(_dateController.text);
        }
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
