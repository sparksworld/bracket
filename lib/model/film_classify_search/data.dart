import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'list.dart';
import 'page.dart';
import 'params.dart';
import 'search.dart';
import 'title.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  List<VideoList>? list;
  Page? page;
  Params? params;
  Search? search;
  Title? title;

  Data({this.list, this.page, this.params, this.search, this.title});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      list.hashCode ^
      page.hashCode ^
      params.hashCode ^
      search.hashCode ^
      title.hashCode;
}
