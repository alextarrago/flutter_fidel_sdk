import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'flutter_fidel_sdk_platform_interface.dart';

class MethodChannelFlutterFidelSdk extends FlutterFidelSdkPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_fidel_sdk');

  @override
  Future<String?> launchFidelSDK(String apiKey, String programKey,
      String termsAndConditionsURL, String customerIdentifier,
      {String? programName,
      String? companyName,
      String? privacyURL,
      String? deleteInstructions,
      String? allowedCountries}) async {
    final result =
        await methodChannel.invokeMethod<String>('launch_fidel_sdk', {
      "api_key": apiKey,
      "program_key": programKey,
      "program_name": programName,
      "terms": termsAndConditionsURL,
      "customerId": customerIdentifier,
      "companyName": companyName,
      "privacyURL": privacyURL,
      "deleteInstructions": deleteInstructions,
      "allowedCountries": allowedCountries
    });
    return result;
  }
}
