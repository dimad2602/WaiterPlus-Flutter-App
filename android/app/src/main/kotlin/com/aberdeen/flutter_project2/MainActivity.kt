package com.aberdeen.flutter_project2

//import io.flutter.embedding.android.FlutterActivity
//
//class MainActivity: FlutterActivity() {
//}

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setLocale("YOUR_LOCALE") // Your preferred language. Not required, defaults to system language
        MapKitFactory.setApiKey("9e4d73cd-c329-42e9-a188-75acbd3ecbfc") // Your generated API key
        super.configureFlutterEngine(flutterEngine)
    }
}