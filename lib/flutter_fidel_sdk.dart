import 'flutter_fidel_sdk_platform_interface.dart';

class FidelSDKError {
  String? errorMessage;
  String? errorCode;

  FidelSDKError({this.errorMessage, this.errorCode});

  @override
  String toString() {
    return 'FidelSDKError{errorMessage: $errorMessage, errorCode: $errorCode}';
  }
}

enum FidelAllowedCountries {
  canada,
  ireland,
  japan,
  sweden,
  unitedArabEmirates,
  unitedKingdom,
  unitedStates,
}

class FlutterFidelSdk {
  static final FlutterFidelSdk _instance = FlutterFidelSdk._internal();

  factory FlutterFidelSdk() => _instance;

  FlutterFidelSdk._internal();

  /*
  * SDK Integration
  * */
  String? apiKey;
  String? programKey;
  String? programName;
  String? termsAndConditionsURL;
  String? customerIdentifier;

  String? companyName;
  String? privacyURL;
  String? deleteInstructions;

  List<FidelAllowedCountries>? allowedCountries = [];

  launchFidelSDK(
      {required Function(FidelSDKError error) onFailed,
      required Function onCompleted,
      required Function onUserCancelled}) async {
    if (apiKey == null || programKey == null) {
      throw Exception("Missing required parameters");
    }
    if (termsAndConditionsURL == null) {
      throw Exception("termsAndConditionsURL is a required parameter");
    }
    if (customerIdentifier == null) {
      throw Exception("customerIdentifier is a required parameter");
    }

    try {
      var nativeData = await FlutterFidelSdkPlatform.instance.launchFidelSDK(
          apiKey!, programKey!, termsAndConditionsURL!, customerIdentifier!,
          programName: programName,
          companyName: companyName,
          privacyURL: privacyURL,
          deleteInstructions: deleteInstructions, allowedCountries: generateCountries());

      if (nativeData == "User canceled card linking.") {
        onUserCancelled();
      } else {
        onCompleted(nativeData);
      }
    } catch (e) {
      onFailed(FidelSDKError(
          errorMessage: "An exception was thrown", errorCode: "1"));
    }
  }

  String? generateCountries() {
    var allowedCountries = "";
    if (this.allowedCountries!.isNotEmpty) {
      for (var country in this.allowedCountries!) {
        allowedCountries += "${country.toString().split('.').last},";
      }
      allowedCountries = allowedCountries.substring(
          0, allowedCountries.length - 1);
    }
    return allowedCountries;

  }
}
