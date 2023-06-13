import Flutter
import UIKit
import Fidel

public class FlutterFidelSdkPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_fidel_sdk", binaryMessenger: registrar.messenger())
        let instance = FlutterFidelSdkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "launch_fidel_sdk" {
            if let args = call.arguments as? Dictionary<String, Any>,
               let apiKey = args["api_key"] as? String,
               let programId = args["program_key"] as? String,
               let programName = args["program_name"] as? String,
               let termsConditionsURL = args["terms"] as? String,
               let customerIdentifier = args["customerId"] as? String {
                
                if let companyName = args["companyName"] as? String {
                    Fidel.companyName = companyName
                }
                if let privacyURL = args["privacyURL"] as? String {
                    Fidel.privacyURL = privacyURL
                }
                if let deleteInstructions = args["deleteInstructions"] as? String {
                    Fidel.deleteInstructions = deleteInstructions
                }

                if let allowedCountries = args["allowedCountries"] as? String {
                    let countries = allowedCountries.split(separator: ",")

                    var allowedCountries: [Country] = []
                    for country in countries {
                        switch country {
                        case "canada": allowedCountries.append(Country.canada)
                        case "unitedArabEmirates": allowedCountries.append(Country.unitedArabEmirates)
                        case "japan": allowedCountries.append(Country.japan)
                        case "ireland": allowedCountries.append(Country.ireland)
                        case "unitedKingdom": allowedCountries.append(Country.unitedKingdom)
                        case "sweden": allowedCountries.append(Country.sweden)
                        case "unitedStates": allowedCountries.append(Country.unitedStates)
                        default: allowedCountries.append(Country.unitedStates)
                        }
                    }
                    if allowedCountries.count != 0 {
                        Fidel.allowedCountries = allowedCountries
                        Fidel.defaultSelectedCountry = allowedCountries[0]
                    }
                }

                Fidel.metaData = [ "id": customerIdentifier ]
                Fidel.apiKey = apiKey
                Fidel.programId = programId
                Fidel.programName = programName
                Fidel.termsConditionsURL = termsConditionsURL

                let rootViewController = UIApplication.shared.windows.filter({ (w) -> Bool in
                    return w.isHidden == false
                }).first?.rootViewController
                
                Fidel.present(rootViewController!, onCardLinkedCallback: { (card: LinkResult) in
                    result(card.id)
                }, onCardLinkFailedCallback: { (err: LinkError) in
                    result(err.message)
                })
            } else {
                result(FlutterError.init(code: "Bad Arguments", message: nil, details: nil))
            }
        } else {
            result(FlutterMethodNotImplemented)
            return
        }
    }
}
