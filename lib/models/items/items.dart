import 'package:flutter_app_for_customers/models/item/item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'items.g.dart';
part 'items.freezed.dart';

@freezed
class Items with _$Items {
  const Items._();

  const factory Items({
    required int id,
    int? restId,
    int? orderId,
    int? amount,
    bool? isComplete,
    required int itemId,
    int? categoryId,
    required Item item,
    String? note,
  }) = _Items;

  factory Items.fromJson(Map<String, Object?> json) => _$ItemsFromJson(json);
}
