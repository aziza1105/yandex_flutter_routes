package com.example.yandex_flutter_routes

import io.flutter.embedding.android.FlutterActivity
import com.yandex.mapkit.MapKitFactory
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant;

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("9b06e327-4adc-4938-b555-e71a4c7d6d61")
        super.configureFlutterEngine(flutterEngine)
    }
}