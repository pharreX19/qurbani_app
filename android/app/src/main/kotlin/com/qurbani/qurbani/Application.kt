package com.qurbani.qurbani

import android.annotation.TargetApi
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.net.Uri
import android.os.Build
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService

class Application : FlutterApplication(), PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
        createChannel()
        FlutterFirebaseMessagingService.setPluginRegistrant(this)
    }

    override fun registerWith(registry: PluginRegistry) {
        FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
//        GeneratedPluginRegistrant.registerWith(registry)
    }

    private fun createChannel(){
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            // Create the NotificationChannel
            val name = getString(R.string.default_notification_channel_id)
            val channel = NotificationChannel(name, "default", NotificationManager.IMPORTANCE_HIGH)
            val notificationManager: NotificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }

//    @TargetApi(Build.VERSION_CODES.O)
//    private fun registerChannel(){
//        val channel: NotificationChannel = NotificationChannel(
//                getString(R.string.default_notification_channel_id),
//                "CiggyGhar Delivery",
//                NotificationManager.IMPORTANCE_HIGH
//        ).also {
//
//            it.setSound(Uri.parse("android.resource://${packageName}/${R.raw.deduction}"), it.audioAttributes)
//        }
//        val manager:NotificationManager = getSystemService(NotificationManager::class.java) as NotificationManager
//        manager.createNotificationChannel(channel)
    }
}