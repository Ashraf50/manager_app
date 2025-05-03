import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/features/dashboard/data/repo/dashboard_repo_impl.dart';
import 'package:overlay_support/overlay_support.dart';

class FirebaseNotificationsHelper {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final BuildContext context;

  FirebaseNotificationsHelper(this.context);

  Future<void> init() async {
    await _requestPermission();
    await _getTokenAndSend();
    _listenToMessages();
  }

  Future<void> _requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('notifications enabled');
    } else {
      print('notifications disabled');
    }
  }

  Future<void> _getTokenAndSend() async {
    try {
      String? token = await _messaging.getToken();
      if (token != null) {
        print("📱 FCM Token: $token");
        final repo = DashboardRepoImpl();
        await repo.sendFcmToken(token);
      }
    } catch (e) {
      print('error get fcm token: $e');
    }
  }

  void _listenToMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      final imageUrl =
          notification?.android?.imageUrl ?? notification?.apple?.imageUrl;
      if (notification != null) {
        showSimpleNotification(
          Row(
            children: [
              if (imageUrl != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.network(
                    imageUrl,
                    height: 35,
                    width: 35,
                    fit: BoxFit.cover,
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title ?? '',
                      style: AppStyles.textStyle16Black,
                    ),
                    Text(
                      notification.body ?? '',
                      style: AppStyles.textStyle16,
                    ),
                  ],
                ),
              ),
            ],
          ),
          background: const Color(0xffF3F2F5),
          duration: const Duration(seconds: 4),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('user click on the notification');
    });
  }
}
