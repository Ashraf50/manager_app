import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/core/helper/api_helper.dart';
import 'package:manager_app/features/dashboard/data/repo/dashboard_repo_impl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/features/notification/presentation/view_model/cubit/notification_cubit.dart';
import 'package:manager_app/features/all_tickets/presentation/view_model/cubit/ticket_cubit.dart';

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
        final repo = DashboardRepoImpl(ApiHelper());
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
      final data = message.data;
      final type = data['type'];
      if (notification != null) {
        showSimpleNotification(
          elevation: 0,
          Material(
            color: Colors.white,
            elevation: 0,
            child: Row(
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
          ),
          background: Colors.white,
          duration: const Duration(seconds: 4),
        );

        try {
          context.read<NotificationCubit>().fetchNotifications(reset: true);
        } catch (e) {
          print('Could not refresh notifications: $e');
        }

        if (type == 'ticket_created' ||
            type == 'ticket_updated' ||
            type == 'ticket_assigned' ||
            type == 'ticket_resolved') {
          try {
            context.read<TicketCubit>().fetchTickets();
          } catch (e) {
            print('Could not refresh tickets: $e');
          }
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('user click on the notification');
      _handleNotificationClick(message);
    });
  }

  void _handleNotificationClick(RemoteMessage message) {
    final data = message.data;
    final type = data['type'];
    final modelId = data['model_id'];
    switch (type) {
      case 'system_notification':
        break;
      case 'ticket_created':
      case 'ticket_updated':
      case 'ticket_assigned':
      case 'ticket_resolved':
        // Navigate to ticket details
        if (modelId != null) {
          // Navigate to ticket details screen
          context.push('/ticket_details', extra: modelId);
        }
        break;
      case 'chat':
        // Navigate to chat
        if (modelId != null) {
          // Navigate to chat screen
          context.push('/chat_details', extra: modelId);
        }
        break;
    }
  }
}
