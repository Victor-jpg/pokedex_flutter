import 'package:compart/controller/home/home_bind.dart';
import 'package:compart/view/home/home_page.dart';
import 'package:compart/view/home/pokemon_details_page.dart';
import 'package:compart/view/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    defaultTransition: Transition.native,
    locale: const Locale("pt", "BR"),
    getPages: [
      GetPage(
        name: "/",
        page: () => const SplashPage(),
      ),
      GetPage(name: "/home", page: () => HomePage(), binding: HomeBind())
    ],
    theme: ThemeData(
        textTheme: TextTheme(
          headline1: GoogleFonts.roboto().copyWith(fontSize: 21),
          headline2: GoogleFonts.roboto().copyWith(fontSize: 19),
          subtitle1: GoogleFonts.roboto().copyWith(fontSize: 16),
          subtitle2: GoogleFonts.roboto().copyWith(fontSize: 14),
        ),
        primaryColor: Colors.red,
        splashColor: Colors.white,
        backgroundColor: Colors.white,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.yellow)),
  ));
}
