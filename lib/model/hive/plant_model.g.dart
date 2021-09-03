// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlantModelAdapter extends TypeAdapter<PlantModel> {
  @override
  final int typeId = 0;

  @override
  PlantModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlantModel(
      plantName: fields[0] as String,
      plantType: fields[1] as PlantTypeEnum,
      plantingDate: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PlantModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.plantName)
      ..writeByte(1)
      ..write(obj.plantType)
      ..writeByte(2)
      ..write(obj.plantingDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlantModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
