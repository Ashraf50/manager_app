import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:manager_app/core/constant/func/get_token.dart';
import 'package:manager_app/core/constant/shared_pref.dart';
import 'package:manager_app/core/helper/api_helper.dart';
import 'package:manager_app/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager_app/features/Auth/data/repo/auth_repo_impl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'my_app.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
  print('Background notification title: ${message.notification?.title}');
  print('Background notification body: ${message.notification?.body}');
  print('Background notification data: ${message.data}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Set background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize other services
  await ScreenUtil.ensureScreenSize();
  sharedPreferences = await SharedPreferences.getInstance();

  // Initialize app state
  final authRepo = AuthRepoImpl(ApiHelper());
  bool isLoggedIn = await authRepo.isLoggedIn();
  final appRouter = AppRouter(isLoggedIn: isLoggedIn);
  final token = await getToken();

  // Run the app
  runApp(
    OverlaySupport.global(
      child: MyApp(
        appRouter: appRouter,
        token: token ?? '',
      ),
    ),
  );
}
