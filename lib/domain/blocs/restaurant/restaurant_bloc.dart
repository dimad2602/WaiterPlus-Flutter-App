import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app_for_customers/models/restaurant/restaurant_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';
part 'restaurant_bloc.freezed.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(const RestaurantState.initial(restaurants: [])) {
    on<RestaurantEvent>((event, emit) async {
      await event.map(
        started: (value) => _started(value, emit),
      );
    });
  }

  FutureOr<void> _started(_Started value, Emitter<RestaurantState> emit) {}
}
