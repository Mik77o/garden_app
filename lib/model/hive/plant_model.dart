import 'package:garden_app/enums/plant_type_enum.dart';
import 'package:hive/hive.dart';
part 'plant_model.g.dart';

@HiveType(typeId: 0)
class PlantModel extends HiveObject {
  PlantModel({
    required this.plantName,
    required this.plantType,
    required this.plantingDate,
  });

  @HiveField(0)
  String plantName;

  @HiveField(1)
  PlantTypeEnum plantType;

  @HiveField(2)
  DateTime plantingDate;
}
