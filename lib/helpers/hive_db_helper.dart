import 'package:garden_app/enums/plant_type_enum.dart';
import 'package:garden_app/model/hive/plant_model.dart';
import 'package:garden_app/model/hive/plant_types_model.dart';

import 'package:hive/hive.dart';

class HiveDbHelper {
  static Box<PlantModel>? getPlants() {
    return Hive.box<PlantModel>('plants');
  }

  static Box<PlantTypeModel>? getPlantTypes() {
    return Hive.box<PlantTypeModel>('plantTypes');
  }

  static Future<dynamic>? addPlant(String plantName, PlantTypeEnum plantType, DateTime plantingDate) {
    final box = getPlants();
    if (box != null) box.add(PlantModel(plantName: plantName, plantType: plantType, plantingDate: plantingDate));
  }

  static Future<dynamic>? addPlantTypes(Box<PlantTypeModel> box) {
    box.add(PlantTypeModel(typesList: PlantTypeEnum.values));
  }

  static Future<dynamic>? editPlant(
    PlantModel plant,
    String plantName,
    PlantTypeEnum plantType,
    DateTime plantingDate,
  ) {
    plant.plantName = plantName;
    plant.plantType = plantType;
    plant.plantingDate = plantingDate;

    final box = getPlants();
    if (box != null) box.put(plant.key, plant);
  }
}
