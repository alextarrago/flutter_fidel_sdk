import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_fidel_sdk_method_channel.dart';

abstract class FlutterFidelSdkPlatform extends PlatformInterface {
  /// Constructs a FlutterFidelSdkPlatform.
  FlutterFidelSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterFidelSdkPlatform _instance = MethodChannelFlutterFidelSdk();

  /// The default instance of [FlutterFidelSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterFidelSdk].
  static FlutterFidelSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterFidelSdkPlatform] when
  /// they register themselves.
  static set instance(FlutterFidelSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> launchFidelSDK(String apiKey, String programKey, String termsAndConditionsURL,
      {String? programName}) {
    throw UnimplementedError('launchFidelSDK() has not been implemented.');
  }
}
