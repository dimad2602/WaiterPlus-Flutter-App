// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RestaurantEmployeeImpl _$$RestaurantEmployeeImplFromJson(
        Map<String, dynamic> json) =>
    _$RestaurantEmployeeImpl(
      id: json['id'] as int,
      employeeId: json['employee_id'] as int,
      restaurantId: json['restaurant_id'] as int,
      email: json['email'] as String,
      emailVerified: json['email_verified'] as bool,
      passwd: json['passwd'] as String,
    );

Map<String, dynamic> _$$RestaurantEmployeeImplToJson(
        _$RestaurantEmployeeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee_id': instance.employeeId,
      'restaurant_id': instance.restaurantId,
      'email': instance.email,
      'email_verified': instance.emailVerified,
      'passwd': instance.passwd,
    };
