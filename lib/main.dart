  import 'package:firebase_core/firebase_core.dart';
  import 'package:firebase_messaging/firebase_messaging.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:flutter_localizations/flutter_localizations.dart';
  import 'package:masar/firebase_options.dart';
  import 'package:masar/layout/home_layout/cubit/home_layout_cubit.dart';
  import 'package:masar/module/home/cubit/home_cubit.dart';
  import 'package:masar/module/onboarding/onboarding_cubit/onboarding_cubit.dart';
  import 'package:masar/module/setting/cubit/setting_state.dart';
  import 'package:masar/module/splash/splash.dart';
  import 'package:masar/module/splash/splash_cubit.dart/splash_cubit.dart';
  import 'package:masar/shared/components/constant/app_color.dart';
  import 'package:masar/shared/components/constant/app_route.dart';
  import 'package:masar/route.dart';
  import 'package:masar/shared/network/local/cach_helper.dart';
  import 'package:overlay_support/overlay_support.dart';
  import 'module/setting/cubit/setting_cubit.dart';

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
        CachHelper.putBool(key: "noti", value: false);
  
  }
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  Future<void> main()async {
    WidgetsFlutterBinding.ensureInitialized();   
      await CachHelper.inti();
      AppColor.intiColor(CachHelper.getBool(key: "isDark") ?? true);
    runApp(MyApp());
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  }

  class MyApp extends StatelessWidget {
    MyApp({super.key});

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => OnboardingCubit(),
          ),
          
          BlocProvider(
            create: (context) => HomeCubit()..init()
          ),
          BlocProvider(

            create: (context) => HomeLayoutCubit()
          ),
          BlocProvider(
            create: (context) => SettingCubit()..init(),
          ),
          BlocProvider(
            create: (context) => NavCubit(),

          ),
        ],
        child: BlocConsumer<SettingCubit, SettingState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return OverlaySupport.global(
              child: MaterialApp(
              navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                initialRoute: AppRoute.splash, //"/test",
                routes: routes,
                locale: const Locale('ar'),
                supportedLocales: const [Locale('ar'), Locale('en')],
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                builder: (context, child) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: child!,
                  );
                },
                home: Directionality(textDirection: TextDirection.rtl, child:SplashScreen() ),
                theme: ThemeData(
                  fontFamily: "Cairo",
                    appBarTheme: AppBarTheme(
                      backgroundColor: AppColor.greyButton,
                      centerTitle: true,
                      titleTextStyle: TextStyle(color: AppColor.blue, fontSize: 20,),
                    
                    ),
                  scaffoldBackgroundColor: const Color.fromARGB(255, 245, 245, 250),//0xFFEEEEEE//0xFFEFEFEF
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      backgroundColor: AppColor.black,
              
                      elevation: 20.0,
                      //selectedIconTheme: IconThemeData(color: AppColor.secaodColor ),
                      selectedItemColor: AppColor.primaryColor,
                      unselectedItemColor: AppColor.grey,
                      showUnselectedLabels: true,
                      type: BottomNavigationBarType.fixed,
                    )),
                darkTheme: ThemeData(
                    appBarTheme: AppBarTheme(
                      backgroundColor: const Color(0xff191A1F),
                      centerTitle: true,
                      actionsIconTheme: IconThemeData(color: AppColor.blue),
                      titleTextStyle: TextStyle(color: AppColor.blue, fontSize: 20),
                    ),
                    scaffoldBackgroundColor: const Color(0xff191A1F),
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      backgroundColor:
                          const Color(0xFF1F222B), //HexColor('313237'),
              
                      elevation: 20.0,
                      //selectedIconTheme: IconThemeData(color: AppColor.secaodColor ),
                      selectedItemColor: AppColor.primaryColor,
                      unselectedItemColor: AppColor.grey,
                      showUnselectedLabels: true,
                      type: BottomNavigationBarType.fixed,
                    )),
                themeMode: CachHelper.getBool(key: "isDark") ?? true ? ThemeMode.dark : ThemeMode.light,
      
              ),
            );
          },
        ),
      );
    }
  }



