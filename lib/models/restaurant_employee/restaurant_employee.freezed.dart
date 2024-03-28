// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_employee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RestaurantEmployee _$RestaurantEmployeeFromJson(Map<String, dynamic> json) {
  return _RestaurantEmployee.fromJson(json);
}

/// @nodoc
mixin _$RestaurantEmployee {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_id')
  int get employeeId =>
      throw _privateConstructorUsedError; //required User user,
  @JsonKey(name: 'restaurant_id')
  int get restaurantId => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'email_verified')
  bool get emailVerified => throw _privateConstructorUsedError;
  String get passwd => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RestaurantEmployeeCopyWith<RestaurantEmployee> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantEmployeeCopyWith<$Res> {
  factory $RestaurantEmployeeCopyWith(
          RestaurantEmployee value, $Res Function(RestaurantEmployee) then) =
      _$RestaurantEmployeeCopyWithImpl<$Res, RestaurantEmployee>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'employee_id') int employeeId,
      @JsonKey(name: 'restaurant_id') int restaurantId,
      String email,
      @JsonKey(name: 'email_verified') bool emailVerified,
      String passwd});
}

/// @nodoc
class _$RestaurantEmployeeCopyWithImpl<$Res, $Val extends RestaurantEmployee>
    implements $RestaurantEmployeeCopyWith<$Res> {
  _$RestaurantEmployeeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? restaurantId = null,
    Object? email = null,
    Object? emailVerified = null,
    Object? passwd = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int,
      restaurantId: null == restaurantId
          ? _value.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      emailVerified: null == emailVerified
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      passwd: null == passwd
          ? _value.passwd
          : passwd // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RestaurantEmployeeImplCopyWith<$Res>
    implements $RestaurantEmployeeCopyWith<$Res> {
  factory _$$RestaurantEmployeeImplCopyWith(_$RestaurantEmployeeImpl value,
          $Res Function(_$RestaurantEmployeeImpl) then) =
      __$$RestaurantEmployeeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'employee_id') int employeeId,
      @JsonKey(name: 'restaurant_id') int restaurantId,
      String email,
      @JsonKey(name: 'email_verified') bool emailVerified,
      String passwd});
}

/// @nodoc
class __$$RestaurantEmployeeImplCopyWithImpl<$Res>
    extends _$RestaurantEmployeeCopyWithImpl<$Res, _$RestaurantEmployeeImpl>
    implements _$$RestaurantEmployeeImplCopyWith<$Res> {
  __$$RestaurantEmployeeImplCopyWithImpl(_$RestaurantEmployeeImpl _value,
      $Res Function(_$RestaurantEmployeeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? restaurantId = null,
    Object? email = null,
    Object? emailVerified = null,
    Object? passwd = null,
  }) {
    return _then(_$RestaurantEmployeeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int,
      restaurantId: null == restaurantId
          ? _value.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      emailVerified: null == emailVerified
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      passwd: null == passwd
          ? _value.passwd
          : passwd // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RestaurantEmployeeImpl implements _RestaurantEmployee {
  const _$RestaurantEmployeeImpl(
      {required this.id,
      @JsonKey(name: 'employee_id') required this.employeeId,
      @JsonKey(name: 'restaurant_id') required this.restaurantId,
      required this.email,
      @JsonKey(name: 'email_verified') required this.emailVerified,
      required this.passwd});

  factory _$RestaurantEmployeeImpl.fromJson(Map<String, dynamic> json) =>
      _$$RestaurantEmployeeImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'employee_id')
  final int employeeId;
//required User user,
  @override
  @JsonKey(name: 'restaurant_id')
  final int restaurantId;
  @override
  final String email;
  @override
  @JsonKey(name: 'email_verified')
  final bool emailVerified;
  @override
  final String passwd;

  @override
  String toString() {
    return 'RestaurantEmployee(id: $id, employeeId: $employeeId, restaurantId: $restaurantId, email: $email, emailVerified: $emailVerified, passwd: $passwd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantEmployeeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.emailVerified, emailVerified) ||
                other.emailVerified == emailVerified) &&
            (identical(other.passwd, passwd) || other.passwd == passwd));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, employeeId, restaurantId, email, emailVerified, passwd);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantEmployeeImplCopyWith<_$RestaurantEmployeeImpl> get copyWith =>
      __$$RestaurantEmployeeImplCopyWithImpl<_$RestaurantEmployeeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RestaurantEmployeeImplToJson(
      this,
    );
  }
}

abstract class _RestaurantEmployee implements RestaurantEmployee {
  const factory _RestaurantEmployee(
      {required final int id,
      @JsonKey(name: 'employee_id') required final int employeeId,
      @JsonKey(name: 'restaurant_id') required final int restaurantId,
      required final String email,
      @JsonKey(name: 'email_verified') required final bool emailVerified,
      required final String passwd}) = _$RestaurantEmployeeImpl;

  factory _RestaurantEmployee.fromJson(Map<String, dynamic> json) =
      _$RestaurantEmployeeImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'employee_id')
  int get employeeId;
  @override //required User user,
  @JsonKey(name: 'restaurant_id')
  int get restaurantId;
  @override
  String get email;
  @override
  @JsonKey(name: 'email_verified')
  bool get emailVerified;
  @override
  String get passwd;
  @override
  @JsonKey(ignore: true)
  _$$RestaurantEmployeeImplCopyWith<_$RestaurantEmployeeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
