import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User{
  const factory User({
    required int id,
    required String name,
    required String email,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'email_verified') required bool emailVerified,
    required String passwd,
    //required String created_at,
    //required String udated_at,
    //required List<Order> orders,
    //required RestaurantEmployee works,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json)
      => _$UserFromJson(json);
}