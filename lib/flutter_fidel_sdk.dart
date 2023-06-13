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

    try {
      var nativeData = await FlutterFidelSdkPlatform.instance.launchFidelSDK(
          apiKey!, programKey!, termsAndConditionsURL!,
          programName: programName);

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
}
