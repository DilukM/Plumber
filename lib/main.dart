import 'package:plumber/Pages/ProductsHome/BuyProducts/home.dart';

import 'package:plumber/Pages/Login.dart';
import 'package:plumber/Pages/JobsHome/PostJob/jobPostMain.dart';
import 'package:plumber/Pages/ProductsHome/SellProduct/sellProductMain.dart';
import 'package:plumber/Pages/ProductsHome/products.dart';


import 'package:plumber/Pages/chat.dart';
import 'package:plumber/Pages/faq.dart';
import 'package:plumber/Pages/myAds.dart';
import 'package:plumber/Pages/onbord.dart';
import 'package:plumber/Pages/privacy.dart';
import 'package:plumber/Pages/profile.dart';
import 'package:plumber/Pages/search.dart';
import 'package:plumber/Pages/setup.dart';
import 'package:plumber/Pages/terms.dart';
import 'package:plumber/Pages/welcome.dart';
import 'package:plumber/firebase_options.dart';
import 'package:plumber/global/globalValues.dart';
import 'package:plumber/provider/location_provider.dart';
import 'package:plumber/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'provider/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => Global(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => CustomAuthProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => LocationData(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fix It Now',
          themeMode: ThemeMode.system,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.lightTheme,
          initialRoute: '/welcome',
          routes: {
            '/products': (context) => ProductSelection(),

            '/welcome': (context) => const Welcome(),
            '/onbord': (context) => const Onbord(),
            '/login': (context) => const Login(),
            '/setup': (context) => const Setup(),

            //Jobs
            '/search': (context) => const Search(),
            '/chat': (context) => const ChatPage(),
            '/profile': (context) => const Profile(),

            //PostJobs
            '/postJobHome': (context) => const JobPostMainPage(),


            //products
            '/sellProduct': (context) => const SellProductsMainPage(),
            '/productsMain': (context) => const ProductsHomePage(),

            //profile
            '/privacy': (context) => PrivacyPolicy(),
            '/terms': (context) => TermsCondition(),
            '/faq': (context) => FaQ(),
            '/myads': (context) => MyAds(),
          },
        ));
  }
}
