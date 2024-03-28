// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartModelImpl _$$CartModelImplFromJson(Map<String, dynamic> json) =>
    _$CartModelImpl(
      id: json['id'] as String,
      itemName: json['itemName'] as String,
      itemPrice: json['itemPrice'] as String,
      description: json['description'] as String?,
      weight: json['weight'] as int?,
      volume: json['volume'] as int?,
      imagePath: json['imagePath'] as String?,
      quantity: json['quantity'] as int,
      time: json['time'] as String?,
      restaurantId: json['restaurantId'] as String?,
      item: Item.fromJson(json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CartModelImplToJson(_$CartModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemName': instance.itemName,
      'itemPrice': instance.itemPrice,
      'description': instance.description,
      'weight': instance.weight,
      'volume': instance.volume,
      'imagePath': instance.imagePath,
      'quantity': instance.quantity,
      'time': instance.time,
      'restaurantId': instance.restaurantId,
      'item': instance.item,
    };
