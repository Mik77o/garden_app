import 'package:flutter/material.dart';
import 'package:garden_app/pages/plants_list_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: Locale('PL'),
        debugShowCheckedModeBanner: false,
        title: 'Plants App',
        theme: ThemeData(
          primarySwatch: MaterialColor(0xff455a64, primarySwatchColor),
          textTheme: GoogleFonts.vollkornTextTheme(),
          brightness: Brightness.light,
          buttonColor: Color(0xff004d40),
          accentColor: Color(0xff004d40),
          primaryColor: Color(0xff004d40),
          primaryColorDark: Color(0xff00251a),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            brightness: Brightness.dark,
            textTheme: TextTheme(
              headline6: GoogleFonts.vollkorn(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlantsListPage());
  }

  final Map<int, Color> primarySwatchColor = {
    50: Color.fromRGBO(0, 77, 64, .1),
    100: Color.fromRGBO(0, 77, 64, .2),
    200: Color.fromRGBO(0, 77, 64, .3),
    300: Color.fromRGBO(0, 77, 64, .4),
    400: Color.fromRGBO(0, 77, 64, .5),
    500: Color.fromRGBO(0, 77, 64, .6),
    600: Color.fromRGBO(0, 77, 64, .7),
    700: Color.fromRGBO(0, 77, 64, .8),
    800: Color.fromRGBO(0, 77, 64, .9),
    900: Color.fromRGBO(0, 77, 64, 1),
  };
}
