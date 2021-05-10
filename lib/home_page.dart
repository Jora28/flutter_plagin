import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = const MethodChannel("micro.flutter.dev/battery");

  String? _batteryLevel = 'Unknown battery level.';
  String? _sizeDivice = 'Unknown size .';

  Future<void>? _getBatareyLevel() async {
    String? batteryLevel;
    String? deviceSize;
    try {
      final int result = await platform.invokeMethod("getBatteryLevel");
      final String size = await platform.invokeMethod("getDeviceSize");
      batteryLevel = "Battarey level at $result % .";
      deviceSize = "Device size $size";
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
      deviceSize = "Failed to get deviceSize: '${e.message}'.";
    }
    setState(() {
      _batteryLevel = batteryLevel!;
      _sizeDivice = deviceSize!;
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget? _body() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        ElevatedButton(
            onPressed: _getBatareyLevel, 
            child: Text("Get Batterey Level")),
        Text(_batteryLevel!),
        Text(_sizeDivice!),
      ]),
    );
  }
}
