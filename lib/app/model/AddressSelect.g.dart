// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddressSelect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressSelect _$AddressSelectFromJson(Map<String, dynamic> json) =>
    AddressSelect(
      placeId: json['place_id'] as String?,
      placeName: json['place_name'] as String?,
      placeParentId: json['place_parent_id'] as String?,
      level: json['level'] as String?,
    );

Map<String, dynamic> _$AddressSelectToJson(AddressSelect instance) =>
    <String, dynamic>{
      'place_id': instance.placeId,
      'place_name': instance.placeName,
      'place_parent_id': instance.placeParentId,
      'level': instance.level,
    };
