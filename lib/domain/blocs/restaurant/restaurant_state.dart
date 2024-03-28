part of 'restaurant_bloc.dart';

@freezed
class RestaurantState with _$RestaurantState {
  const factory RestaurantState.initial({
    required List<Restaurant> restaurants,
  }) = _Initial;
}
