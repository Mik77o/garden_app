// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_type_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlantTypeEnumAdapter extends TypeAdapter<PlantTypeEnum> {
  @override
  final int typeId = 2;

  @override
  PlantTypeEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PlantTypeEnum.Alpines;
      case 1:
        return PlantTypeEnum.Aquatic;
      case 2:
        return PlantTypeEnum.Bulbs;
      case 3:
        return PlantTypeEnum.Succulents;
      case 4:
        return PlantTypeEnum.Carnivorous;
      case 5:
        return PlantTypeEnum.Climbers;
      case 6:
        return PlantTypeEnum.Ferns;
      case 7:
        return PlantTypeEnum.Grasses;
      case 8:
        return PlantTypeEnum.Threes;
      default:
        return PlantTypeEnum.Alpines;
    }
  }

  @override
  void write(BinaryWriter writer, PlantTypeEnum obj) {
    switch (obj) {
      case PlantTypeEnum.Alpines:
        writer.writeByte(0);
        break;
      case PlantTypeEnum.Aquatic:
        writer.writeByte(1);
        break;
      case PlantTypeEnum.Bulbs:
        writer.writeByte(2);
        break;
      case PlantTypeEnum.Succulents:
        writer.writeByte(3);
        break;
      case PlantTypeEnum.Carnivorous:
        writer.writeByte(4);
        break;
      case PlantTypeEnum.Climbers:
        writer.writeByte(5);
        break;
      case PlantTypeEnum.Ferns:
        writer.writeByte(6);
        break;
      case PlantTypeEnum.Grasses:
        writer.writeByte(7);
        break;
      case PlantTypeEnum.Threes:
        writer.writeByte(8);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlantTypeEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
