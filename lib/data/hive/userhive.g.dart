// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userhive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserHiveAdapter extends TypeAdapter<UserHive> {
  @override
  final int typeId = 1;

  @override
  UserHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserHive(
      user_ID: fields[0] as String,
      full_name: fields[1] as String,
      photoURL: fields[2] as String,
      email: fields[3] as String,
      phone: fields[4] as String,
      blocked: fields[5] as bool,
      deleted_account: fields[6] as bool,
      permanently_blocked: fields[7] as bool,
      signUpComplete: fields[8] as bool,
      emailAuth: fields[9] as bool,
      phoneAuth: fields[10] as bool,
      googleAuth: fields[11] as bool,
      userRating: fields[12] as double,
    );
  }

  @override
  void write(BinaryWriter writer, UserHive obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.user_ID)
      ..writeByte(1)
      ..write(obj.full_name)
      ..writeByte(2)
      ..write(obj.photoURL)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.blocked)
      ..writeByte(6)
      ..write(obj.deleted_account)
      ..writeByte(7)
      ..write(obj.permanently_blocked)
      ..writeByte(8)
      ..write(obj.signUpComplete)
      ..writeByte(9)
      ..write(obj.emailAuth)
      ..writeByte(10)
      ..write(obj.phoneAuth)
      ..writeByte(11)
      ..write(obj.googleAuth)
      ..writeByte(12)
      ..write(obj.userRating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocationHiveAdapter extends TypeAdapter<LocationHive> {
  @override
  final int typeId = 2;

  @override
  LocationHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationHive(
      latitude: fields[0] as double,
      longitude: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, LocationHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PickUpAddressHiveAdapter extends TypeAdapter<PickUpAddressHive> {
  @override
  final int typeId = 3;

  @override
  PickUpAddressHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PickUpAddressHive(
      placeName: fields[0] as String?,
      latitude: fields[1] as double?,
      longitude: fields[2] as double?,
      placeId: fields[3] as String?,
      placeFormattedAddress: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PickUpAddressHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.placeName)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.longitude)
      ..writeByte(3)
      ..write(obj.placeId)
      ..writeByte(4)
      ..write(obj.placeFormattedAddress);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PickUpAddressHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
