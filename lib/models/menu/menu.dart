import 'package:flutter_app_for_customers/models/items/items.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu.freezed.dart';
part 'menu.g.dart';

@freezed
class Menu with _$Menu {
  const factory Menu({
    required int id,
    String? title,
    required int restId, //@JsonKey(name: 'rest_id')
    List<Items>? items,
  }) = _Menu;

  factory Menu.fromJson(Map<String, Object?> json) =>
      _$MenuFromJson(json);
}