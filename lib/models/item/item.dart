import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.g.dart';
part 'item.freezed.dart';

@freezed
class Item with _$Item{
  const Item._();

  const factory Item({
    required int id,
    required String title,
    String? description,
    int? weight,
    int? volume,
    required double price,
    String? image,
    //
  }) = _Item;

    factory Item.fromJson(Map<String, Object?> json)
      => _$ItemFromJson(json);
}
