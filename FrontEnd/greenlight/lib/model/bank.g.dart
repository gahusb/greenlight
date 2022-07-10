// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Bank _$$_BankFromJson(Map<String, dynamic> json) => _$_Bank(
      id: json['id'] as int,
      title: json['title'] as String,
      tel: json['tel'] as String,
      zipcode: json['zipcode'] as String,
      address: json['address'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      imagePath: json['imagePath'] as String,
      organName: json['organ_name'] as String,
      organVolumn: json['organ_volumn'] as int,
    );

Map<String, dynamic> _$$_BankToJson(_$_Bank instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'tel': instance.tel,
      'zipcode': instance.zipcode,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'imagePath': instance.imagePath,
      'organ_name': instance.organName,
      'organ_volumn': instance.organVolumn,
    };
