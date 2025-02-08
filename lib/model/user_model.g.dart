// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../screens/user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      name: fields[0] as String,
      email: fields[1] as String,
      gender: fields[2] as String,
      dob: fields[3] as String,
      pincode: fields[4] as String,
      state: fields[5] as String,
      address: fields[6] as String,
      jobTitle: fields[7] as String,
      companyName: fields[8] as String,
      workExperience: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.gender)
      ..writeByte(3)
      ..write(obj.dob)
      ..writeByte(4)
      ..write(obj.pincode)
      ..writeByte(5)
      ..write(obj.state)
      ..writeByte(6)
      ..write(obj.address)
      ..writeByte(7)
      ..write(obj.jobTitle)
      ..writeByte(8)
      ..write(obj.companyName)
      ..writeByte(9)
      ..write(obj.workExperience);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
