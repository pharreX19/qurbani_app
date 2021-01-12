package com.qurbani.qurbani

import android.Manifest.permission.*
import android.content.Context
import android.content.pm.PackageManager
import android.telephony.TelephonyManager
import android.util.Log
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    val channel : String = "flutter/qurbani_app";
    lateinit var result : MethodChannel.Result;
    lateinit var telephonyManager : TelephonyManager;
    val permissionCode : Int = 100;


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler{
            call, result ->
                if(call.method == "fetchContactNumber"){
                    this.result = result;
                    telephonyManager = getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager;
                    fetchPhoneNumber();

            }
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        when(requestCode){
            permissionCode -> {
                if(grantResults[0] == PackageManager.PERMISSION_GRANTED){
                    Log.i("MESSAGE", "PERMISSION GRANTER")
//                    Log.i("MESSAGE", telephonyManager.line1Number)
                    fetchPhoneNumber();
                }
            }
        }
    }

    private fun fetchPhoneNumber(){
        Log.i("MESSAGE", "FTECH PHONE NUMBER STARTS")

        if(//ActivityCompat.checkSelfPermission(this, READ_SMS) == PackageManager.PERMISSION_GRANTED &&
                //ActivityCompat.checkSelfPermission(this, READ_PHONE_NUMBERS) == PackageManager.PERMISSION_GRANTED &&
                ActivityCompat.checkSelfPermission(this, READ_PHONE_STATE) == PackageManager.PERMISSION_GRANTED){
            Log.i("MESSAGE", "TESTING")
            Log.i("MESSAGE", telephonyManager.line1Number)
            Log.i("MESSAGE", telephonyManager.simCountryIso)

            this.result.success(mapOf<String, String>("phone_number" to telephonyManager.line1Number, "country" to telephonyManager.simCountryIso))
        }else{
            Log.i("MESSAGE", "ASK PERMSION FROM FUNCTION")

            ActivityCompat.requestPermissions(this, arrayOf(READ_PHONE_STATE/*, READ_SMS, READ_PHONE_NUMBERS*/), permissionCode)
        }
    }

}
