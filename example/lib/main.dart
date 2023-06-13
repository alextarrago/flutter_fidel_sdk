import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_fidel_sdk/flutter_fidel_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterFidelSdkPlugin = FlutterFidelSdk();

  @override
  void initState() {
    super.initState();
  }

  Future<void> launchFidelSDK() async {
    _flutterFidelSdkPlugin.apiKey = "<YOUR_API_KEY>";
    _flutterFidelSdkPlugin.programKey = "<PROGRAM_KEY>";
    _flutterFidelSdkPlugin.programName = "<PROGRAM_NAME>";
    _flutterFidelSdkPlugin.termsAndConditionsURL = "<TERMS_AND_CONDS_URL>";
    _flutterFidelSdkPlugin.launchFidelSDK(
        onCompleted: (data) {
          print(data);
        },
        onUserCancelled: () {
          print("User cancelled");
        },
        onFailed: (error) {
          print(error);
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FIDEL SDK Example'),
        ),
        body: Center(
          child: OutlinedButton(
            onPressed: () async {
              launchFidelSDK();
            },
            child: const Text('Launch Native Screen'),
          ),
        ),
      ),
    );
  }
}
