// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Relate _$RelateFromJson(Map<String, dynamic> json) => Relate(
      id: json['id'] as int?,
      cid: json['cid'] as int?,
      pid: json['pid'] as int?,
      name: json['name'] as String?,
      subTitle: json['subTitle'] as String?,
      cName: json['cName'] as String?,
      state: json['state'] as String?,
      picture: json['picture'] as String?,
      actor: json['actor'] as String?,
      director: json['director'] as String?,
      blurb: json['blurb'] as String?,
      remarks: json['remarks'] as String?,
      area: json['area'] as String?,
      year: json['year'] as String?,
    );

Map<String, dynamic> _$RelateToJson(Relate instance) => <String, dynamic>{
      'id': instance.id,
      'cid': instance.cid,
      'pid': instance.pid,
      'name': instance.name,
      'subTitle': instance.subTitle,
      'cName': instance.cName,
      'state': instance.state,
      'picture': instance.picture,
      'actor': instance.actor,
      'director': instance.director,
      'blurb': instance.blurb,
      'remarks': instance.remarks,
      'area': instance.area,
      'year': instance.year,
    };