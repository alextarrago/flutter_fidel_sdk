#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_fidel_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_fidel_sdk'
  s.version          = '0.8.0'
  s.summary          = 'A Flutter plugin integrating the Fidel SDK for Android and iOS.'
  s.description      = <<-DESC
A Flutter plugin integrating the Fidel SDK for Android and iOS.
                       DESC
  s.homepage         = 'http://dribba.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Dribba' => 'alex@dribba.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'Fidel'

  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
