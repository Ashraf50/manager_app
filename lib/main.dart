import 'package:manager_app/core/constant/func/get_token.dart';
import 'package:manager_app/core/helper/api_helper.dart';
import 'package:manager_app/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager_app/features/Auth/data/repo/auth_repo_impl.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  final authRepo = AuthRepoImpl(ApiHelper());
  bool isLoggedIn = await authRepo.isLoggedIn(); //save login state
  final appRouter = AppRouter(isLoggedIn: isLoggedIn);
  final token = await getToken();
  runApp(MyApp(
    appRouter: appRouter,
    token: token ?? '',
  ));
}
