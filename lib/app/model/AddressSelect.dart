import 'package:json_annotation/json_annotation.dart';

part 'AddressSelect.g.dart';

@JsonSerializable()
class AddressSelect {
  @JsonKey(name: "place_id")
  String? Id;
  @JsonKey(name: "place_name")
  String? Value;
  @JsonKey(name: "place_parent_id")
  String? placeParentId;
  @JsonKey(name: "level")
  String? level;

  AddressSelect({
    this.Id,
    this.Value,
    this.placeParentId,
    this.level,
  });

  factory AddressSelect.fromJson(Map<String, dynamic> json) =>
      _$AddressSelectFromJson(json);

  Map<String, dynamic> toJson() => _$AddressSelectToJson(this);
}
