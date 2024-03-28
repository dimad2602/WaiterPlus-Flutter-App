import 'package:flutter_app_for_customers/models/brand/brand_model.dart';
import 'package:flutter_app_for_customers/models/geometry/geometry_model.dart';
import 'package:flutter_app_for_customers/models/menu/menu.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_model.freezed.dart';
part 'restaurant_model.g.dart';

@freezed
class Restaurant with _$Restaurant {
  const factory Restaurant({
    required int id,
    Brand? brand,
    required String description,
    required String img,
    String? address,
    int? costs,
    String? phone,
    String? time,
    Geometry? geometry,
    required int restId, //@JsonKey(name: 'rest_id')
    List<Menu>? menu,
  }) = _Restaurant;

  factory Restaurant.fromJson(Map<String, Object?> json) =>
      _$RestaurantFromJson(json);
}
