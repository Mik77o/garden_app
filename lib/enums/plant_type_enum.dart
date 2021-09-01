import 'package:hive/hive.dart';
part 'plant_type_enum.g.dart';

@HiveType(typeId: 2)
enum PlantTypeEnum {
  @HiveField(0)
  Alpines,
  @HiveField(1)
  Aquatic,
  @HiveField(2)
  Bulbs,
  @HiveField(3)
  Succulents,
  @HiveField(4)
  Carnivorous,
  @HiveField(5)
  Climbers,
  @HiveField(6)
  Ferns,
  @HiveField(7)
  Grasses,
  @HiveField(8)
  Threes,
}

const Map<PlantTypeEnum, String> PlantTypeEnumToString = {
  PlantTypeEnum.Alpines: "Alpines",
  PlantTypeEnum.Aquatic: "Aquatic",
  PlantTypeEnum.Bulbs: "Bulbs",
  PlantTypeEnum.Succulents: "Succulents",
  PlantTypeEnum.Carnivorous: "Carnivorous",
  PlantTypeEnum.Climbers: "Climbers",
  PlantTypeEnum.Ferns: "Ferns",
  PlantTypeEnum.Grasses: "Grasses",
  PlantTypeEnum.Threes: "Threes"
};
