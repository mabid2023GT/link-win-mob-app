import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/features/auth/auth_screen.dart';
import 'package:link_win_mob_app/features/home/homepage.dart';
import 'package:link_win_mob_app/features/on_boarding/on_boarding_screen.dart';
import 'package:link_win_mob_app/providers/auth/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initFirebase();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

_initFirebase() async {
  // Initialize Firebase here
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCPTouOgZW1RSZedMbCC9PcDG4w7yS9S2s",
        appId: "1:951002606:web:8d1a1012b8153106e29aff",
        messagingSenderId: "951002606",
        projectId: "link-win-daf7d",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return Consumer(
          builder: (context, ref, child) {
            final authState = ref.watch(authProvider);
            if (authState.user != null) {
              // User is signed in, redirect to home
              return const HomePage();
            } else {
              // User is not signed in, show onboarding
              return const OnBoardingScreen();
            }
          },
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'auth',
          builder: (BuildContext context, GoRouterState state) {
            return AuthScreen();
          },
        ),
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LinkWin',
      debugShowCheckedModeBanner: false,
      theme: kAppThemeData,
      routerConfig: _router,
    );
  }
}

final ThemeData kAppThemeData = _buildAppTheme();

ThemeData _buildAppTheme() {
  final base = ThemeData.light();
  final baseTextTheme = GoogleFonts.poppinsTextTheme(base.textTheme);
  return base.copyWith(
    scaffoldBackgroundColor: kWhite,
    appBarTheme: const AppBarTheme(
      backgroundColor: transparent,
      elevation: 0.0,
    ),
    textTheme: baseTextTheme.copyWith(
      // Title
      displayLarge: baseTextTheme.displayLarge!.copyWith(
        height: 58.5 / 39,
        fontWeight: FontWeight.w700,
        fontSize: 39.0,
        color: kBlack,
      ),
      // H1
      displayMedium: baseTextTheme.displayMedium!.copyWith(
        height: 46.88 / 31.25,
        fontWeight: FontWeight.w700,
        fontSize: 31.25,
        color: kBlack,
      ),
      // H2
      displaySmall: baseTextTheme.displaySmall!.copyWith(
        height: 37.5 / 25.0,
        fontWeight: FontWeight.w400,
        fontSize: 25.0,
        color: kBlack,
      ),
      // H3, Button Large
      headlineSmall: baseTextTheme.headlineSmall!.copyWith(
        height: 30.0 / 20.0,
        fontWeight: FontWeight.w400,
        fontSize: 20.0,
        color: kBlack,
      ),
      // Body Regular (Body Copy), Button Regular
      bodyLarge: baseTextTheme.bodyLarge!.copyWith(
        color: kBlack,
        fontWeight: FontWeight.w400,
      ),
      // Body Small
      bodySmall: baseTextTheme.bodySmall!.copyWith(
        height: 21.0 / 14.0,
        fontWeight: FontWeight.w700,
        fontSize: 14.0,
        color: kBlack,
      ),
      // Caption
      labelSmall: baseTextTheme.labelSmall!.copyWith(
        height: 19.2 / 12.8,
        fontWeight: FontWeight.w400,
        fontSize: 12.8,
        color: kCaption,
      ),
    ),
  );
}
