import 'package:flutter_app_for_customers/domain/api/api_provider.dart';
import 'package:flutter_app_for_customers/utils/constants.dart';

import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<Constants>(() => Constants());
  locator.registerLazySingleton<ApiProvider>(() => ApiProvider(appBaseUrl: 'http://10.0.2.2:3000/'));
}
