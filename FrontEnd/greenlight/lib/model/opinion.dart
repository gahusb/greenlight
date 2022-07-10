import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'opinion.freezed.dart';

part 'opinion.g.dart';

@freezed
class Opinion with _$Opinion {
  factory Opinion({
    required String id,
    required String opinion,
    required DateTime createTime,
  }) = _Opinion;

  factory Opinion.fromJson(Map<String, dynamic> json) => _$OpinionFromJson(json);
}