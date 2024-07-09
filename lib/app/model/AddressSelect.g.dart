// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddressSelect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressSelect _$AddressSelectFromJson(Map<String, dynamic> json) =>
    AddressSelect(
      Id: json['place_id'] as String?,
      Value: json['place_name'] as String?,
      placeParentId: json['place_parent_id'] as String?,
      level: json['level'] as String?,
    );

Map<String, dynamic> _$AddressSelectToJson(AddressSelect instance) =>
    <String, dynamic>{
      'place_id': instance.Id,
      'place_name': instance.Value,
      'place_parent_id': instance.placeParentId,
      'level': instance.level,
    };
