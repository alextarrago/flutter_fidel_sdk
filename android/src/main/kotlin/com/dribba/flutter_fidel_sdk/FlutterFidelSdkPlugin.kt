package com.dribba.flutter_fidel_sdk

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.android.FlutterActivity
import com.fidel.sdk.Fidel
import com.fidel.sdk.LinkResult
import com.fidel.sdk.LinkResultError
import com.fidel.sdk.data.abstraction.FidelCardLinkingObserver
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

class FlutterFidelSdkPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var activity: Activity

    override fun onDetachedFromActivity() {

    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {

    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity;
    }

    override fun onDetachedFromActivityForConfigChanges() {

    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext

        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_fidel_sdk")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "launch_fidel_sdk") {
            val apiKey: String? = call.argument("api_key");
            val programKey: String? = call.argument("program_key");
            val programName: String? = call.argument("program_name");
            val terms: String? = call.argument("terms");

            Fidel.apiKey = apiKey;
            Fidel.programId = programKey;
            Fidel.programName = programName;
            Fidel.termsConditionsURL = terms;

            Fidel.setCardLinkingObserver(object : FidelCardLinkingObserver {
                override fun onCardLinkingFailed(linkResultError: LinkResultError) {
                    result.error("", linkResultError.message, "")
                }
                override fun onCardLinkingSucceeded(linkResult: LinkResult) {
                    result.success(linkResult.id);
                }
            })
            Fidel.present(activity);
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
