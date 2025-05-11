import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
import 'package:manager_app/features/dashboard/data/repo/dashboard_repo_impl.dart';
import 'package:manager_app/features/dashboard/presentation/view_model/cubit/statistics_cubit.dart';
import 'package:manager_app/features/home/presentation/view_model/cubit/user_data_cubit.dart';
import 'package:manager_app/features/notification/data/repo/notification_repo_impl.dart';
import 'package:manager_app/features/notification/presentation/view_model/cubit/notification_cubit.dart';
import 'package:manager_app/generated/l10n.dart';
import 'core/helper/api_helper.dart';
import 'features/Auth/presentation/view_model/bloc/auth_bloc.dart';
import 'features/home/data/repo/user_repo_impl.dart';
import 'features/settings/presentation/view_model/language_bloc/language_bloc.dart';

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
          create: (context) => StatisticsCubit(DashboardRepoImpl(ApiHelper()))
            ..fetchStatistics(),
        ),
        BlocProvider(
          create: (context) =>
              NotificationCubit(NotificationRepoImpl(ApiHelper()))
                ..fetchNotifications(),
        ),
        BlocProvider(
            create: (context) =>
                CreateTicketianCubit(TicketianRepoImpl(ApiHelper()))),
        BlocProvider(
          create: (context) => LanguageBloc(),
        ),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            return MaterialApp.router(
              builder: FlutterSmartDialog.init(),
              theme: ThemeData(scaffoldBackgroundColor: Colors.white),
              routerConfig: appRouter.router,
              debugShowCheckedModeBanner: false,
              locale:
                  state is AppChangeLanguage ? Locale(state.langCode) : null,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              localeListResolutionCallback: (deviceLocales, supportedLocales) {
                if (deviceLocales != null) {
                  for (var deviceLocale in deviceLocales) {
                    for (var supportedLocale in supportedLocales) {
                      if (deviceLocale.languageCode ==
                          supportedLocale.languageCode) {
                        return deviceLocale;
                      }
                    }
                  }
                }
                return supportedLocales.first;
              },
            );
          },
        ),
      ),
    );
  }
}
