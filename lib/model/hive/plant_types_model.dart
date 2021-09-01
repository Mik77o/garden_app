import 'package:garden_app/enums/plant_type_enum.dart';
import 'package:hive/hive.dart';
part 'plant_types_model.g.dart';

@HiveType(typeId: 1)
class PlantTypeModel extends HiveObject {
  PlantTypeModel({
    required this.typesList,
  });

  @HiveField(0)
  List<PlantTypeEnum> typesList;
}
