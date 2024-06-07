import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:memorial_book/provider/account_provider.dart';
import 'package:memorial_book/provider/auth_provider.dart';
import 'package:memorial_book/provider/catalog_provider.dart';
import 'package:memorial_book/provider/filter_provider.dart';
import 'package:memorial_book/provider/marketplace_provider.dart';
import 'package:memorial_book/provider/message_dialogs_provider.dart';
import 'package:memorial_book/provider/onboarding_indicator_provider.dart';
import 'package:memorial_book/provider/profile_creation_provider.dart';
import 'package:memorial_book/provider/profile_provider.dart';
import 'package:memorial_book/provider/tab_bar_provider.dart';
import 'package:memorial_book/screens/defining_flow_account.dart';
import 'package:memorial_book/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MemorialBookApp extends StatefulWidget {
  const MemorialBookApp({Key? key}) : super(key: key);

  @override
  State<MemorialBookApp> createState() => _MemorialBookAppState();
}

class _MemorialBookAppState extends State<MemorialBookApp> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OnboardingIndicatorProvider>(
          create: (_) => OnboardingIndicatorProvider(context),
        ),
        ChangeNotifierProvider<MessageDialogsProvider>(
          create: (_) => MessageDialogsProvider(),
        ),
        ChangeNotifierProvider<TabBarProvider>(
          create: (_) => TabBarProvider(),
        ),
        ChangeNotifierProvider<ProfileProvider>(
          create: (_) => ProfileProvider(),
        ),
        ChangeNotifierProvider<FilterProvider>(
          create: (_) => FilterProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<ProfileCreationProvider>(
          create: (_) => ProfileCreationProvider(),
        ),
        ChangeNotifierProvider<CatalogProvider>(
          create: (_) => CatalogProvider(),
        ),
        ChangeNotifierProvider<AccountProvider>(
          create: (_) => AccountProvider(),
        ),
        ChangeNotifierProvider<MarketplaceProvider>(
          create: (_) => MarketplaceProvider(),
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            localizationsDelegates: const [
            ],
            theme: ThemeData(
              useMaterial3: true,
              textSelectionTheme: const TextSelectionThemeData(
                selectionColor: Color.fromRGBO(23, 94, 217, 1),
                selectionHandleColor: Color.fromRGBO(23, 94, 217, 1),
                cursorColor: Color.fromRGBO(23, 94, 217, 1),
              ),
              // scrollbarTheme: ScrollbarThemeData(
              //   thumbVisibility: MaterialStateProperty.all(true),
              //   trackVisibility: MaterialStateProperty.all(true),
              //   trackColor: MaterialStateProperty.all(Color.fromRGBO(32, 30, 31, 0.2)),
              //
              //   interactive: true,
              //   mainAxisMargin: 6.h,
              //   crossAxisMargin: 1.w,
              //   thickness: MaterialStateProperty.all(1.w),
              //   thumbColor: MaterialStateProperty.all(const Color.fromRGBO(23, 94, 217, 1)),
              //   radius: const Radius.circular(10),
              //   minThumbLength: 10.h,
              // ),
            ),
            debugShowCheckedModeBanner: false,
            home: const AnimationManager(),
          );
        },
      ),
    );
  }
}

class AnimationManager extends StatefulWidget {
  const AnimationManager({Key? key}) : super(key: key);

  @override
  State<AnimationManager> createState() => _AnimationManagerState();
}

class _AnimationManagerState extends State<AnimationManager> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    authProvider.showOnboardingForNewFag();
    authProvider.defineRole();
    return AnimatedSplashScreen(
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: double.maxFinite,
      splash: const SplashScreen(),
      duration: 1000,
      nextScreen: DefiningFlowAccount(
        userToken: authProvider.getTokenUser,
        userRules: authProvider.getUserRules,
      ),
    );
  }
}
