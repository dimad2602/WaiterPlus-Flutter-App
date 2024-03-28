import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand_model.g.dart';
part 'brand_model.freezed.dart';

@freezed
class Brand with _$Brand{
  const Brand._();

  const factory Brand({
    required int id,
    int? company,
    required String name,
    List<String>? restaurants,
  }) = _Brand;

    factory Brand.fromJson(Map<String, Object?> json)
      => _$BrandFromJson(json);
}
