// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_types_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlantTypeModelAdapter extends TypeAdapter<PlantTypeModel> {
  @override
  final int typeId = 1;

  @override
  PlantTypeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlantTypeModel(
      typesList: (fields[0] as List).cast<PlantTypeEnum>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlantTypeModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.typesList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlantTypeModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
