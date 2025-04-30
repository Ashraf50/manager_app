import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:manager_app/features/Auth/data/repo/auth_repo_impl.dart';
import 'package:manager_app/features/add_ticketian/data/repo/ticketian_repo_impl.dart';
import 'package:manager_app/features/add_ticketian/presentation/view_model/cubit/add_ticketian_cubit.dart';
import 'package:manager_app/features/add_ticketian/presentation/view_model/cubit/create_ticketian_cubit.dart';
import 'package:manager_app/features/all_tickets/data/repo/ticket_repo_impl.dart';
import 'package:manager_app/features/all_tickets/presentation/view_model/cubit/ticket_cubit.dart';
import 'package:manager_app/features/home/presentation/view_model/cubit/user_data_cubit.dart';
import 'package:manager_app/features/notification/data/repo/notification_repo_impl.dart';
import 'package:manager_app/features/notification/presentation/view_model/cubit/notification_cubit.dart';
import 'core/helper/api_helper.dart';
import 'features/Auth/presentation/view_model/bloc/auth_bloc.dart';
import 'features/home/data/repo/user_repo_impl.dart';

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final String token;
  const MyApp({
    super.key,
    required this.appRouter,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthRepoImpl(ApiHelper())),
        ),
        BlocProvider(
          create: (context) =>
              UserDataCubit(UserRepoImpl(ApiHelper()))..fetchUserData(token),
        ),
        BlocProvider(
          create: (context) => AddTicketianCubit(TicketianRepoImpl(ApiHelper()))
            ..fetchTicketian(),
        ),
        BlocProvider(
          create: (context) =>
              TicketCubit(TicketRepoImpl(ApiHelper()))..fetchTickets(),
        ),
        BlocProvider(
          create: (context) =>
              NotificationCubit(NotificationRepoImpl(ApiHelper()))
                ..fetchNotifications(),
        ),
        BlocProvider(
            create: (context) =>
                CreateTicketianCubit(TicketianRepoImpl(ApiHelper()))),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp.router(
          builder: FlutterSmartDialog.init(),
          theme: ThemeData(scaffoldBackgroundColor: Colors.white),
          routerConfig: appRouter.router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
