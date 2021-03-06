import 'package:flutter/material.dart';
import 'package:garden_app/enums/plant_type_enum.dart';
import 'package:garden_app/model/hive/plant_model.dart';
import 'package:garden_app/model/hive/plant_types_model.dart';
import 'package:garden_app/pages/plants_list_page.dart';
import 'package:garden_app/themes/primary_swatch_color_settings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(PlantTypeEnumAdapter());
  Hive.registerAdapter(PlantTypeModelAdapter());
  Hive.registerAdapter(PlantModelAdapter());

  await Hive.openBox<PlantModel>('plants');
  await Hive.openBox<PlantTypeModel>('plantTypes');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: SpinKitSquareCircle(
        color: Color(0xff00251a),
      ),
      child: MaterialApp(
          locale: Locale('PL'),
          debugShowCheckedModeBanner: false,
          title: 'Plants App',
          theme: ThemeData(
            primarySwatch: MaterialColor(0xff004d40, primarySwatchColor),
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
                headline6: GoogleFonts.vollkorn(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: PlantsListPage()),
    );
  }
}
