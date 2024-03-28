// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemsImpl _$$ItemsImplFromJson(Map<String, dynamic> json) => _$ItemsImpl(
      id: json['id'] as int,
      restId: json['restId'] as int?,
      orderId: json['orderId'] as int?,
      amount: json['amount'] as int?,
      isComplete: json['isComplete'] as bool?,
      itemId: json['itemId'] as int,
      categoryId: json['categoryId'] as int?,
      item: Item.fromJson(json['item'] as Map<String, dynamic>),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$ItemsImplToJson(_$ItemsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'restId': instance.restId,
      'orderId': instance.orderId,
      'amount': instance.amount,
      'isComplete': instance.isComplete,
      'itemId': instance.itemId,
      'categoryId': instance.categoryId,
      'item': instance.item,
      'note': instance.note,
    };
