import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:just_list/models/list_model.dart';
import 'package:just_list/models/product_model.dart';
import 'package:just_list/models/saved_purchased_row.dart';
import 'package:just_list/screens/splash_screen/splash_screen.dart';
import 'package:just_list/themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(
    ListModelAdapter(),
  );
  Hive.registerAdapter(
    ProductAdapter(),
  );
  Hive.registerAdapter(
    SavedPurchasedRowAdapter(),
  );

  Box<ListModel> modelsBox = await Hive.openBox<ListModel>('list_models_8');
  Box<SavedPurchasedRow> historicPurchasesBox =
      await Hive.openBox<SavedPurchasedRow>('historic_purchases_box_7');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Just List',
        theme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: SplashScreen());
  }
}
