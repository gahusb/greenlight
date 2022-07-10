import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank.freezed.dart';

part 'bank.g.dart';

@freezed
class Bank with _$Bank {
  factory Bank({
    required int id,
    required String title,
    required String tel,
    required String zipcode,
    required String address,
    required double lat,
    required double lng,
    required String imagePath,
    @JsonKey(name: 'organ_name') required String organName,
    @JsonKey(name: 'organ_volumn') required int organVolumn,
  }) = _Bank;

  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);
}