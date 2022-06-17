import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/Restaurantfromfilter/manager/all_items_provider.dart';
import 'package:kkhaney/Restaurantfromfilter/manager/restaurant_from_filter_provider.dart';
import 'package:kkhaney/splashPage/splashPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context)=>FromFilterRestaurantProvider()
        ),
        ChangeNotifierProvider(
            create: (context)=>AllItemsProvider()
        ),
      ],
      child: KhaltiScope(
        publicKey: "test_public_key_54fb837879174e94a7931cffabc567bc",
        builder: (context,navigatorKey) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,

            ],
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.light().copyWith(primary:Constant.primaryColor,secondary: Constant.secondaryColor),
            ),
            //home: const HomePage(),
            home: SplashPage(),
          );
        }
      ),

    );
  }
}

