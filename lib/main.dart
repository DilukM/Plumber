import 'package:plumber/Pages/JobsHome/jobs.dart';
import 'package:plumber/Pages/ProductsHome/BuyProducts/home.dart';
import 'package:plumber/Pages/JobsHome/Jobs/availableJobs.dart';
import 'package:plumber/Pages/JobsHome/Jobs/browseJobs.dart';
import 'package:plumber/Pages/Login.dart';
import 'package:plumber/Pages/JobsHome/PostJob/jobPostMain.dart';
import 'package:plumber/Pages/ProductsHome/SellProduct/sellProductMain.dart';
import 'package:plumber/Pages/ProductsHome/products.dart';
import 'package:plumber/Pages/ServicesHome/BuyServices/buyServicesHome.dart';
import 'package:plumber/Pages/ServicesHome/SellServices/sellServiceMain.dart';
import 'package:plumber/Pages/ServicesHome/services.dart';
import 'package:plumber/Pages/WholeSaleHome/BuyBulk/buyBulkMain.dart';
import 'package:plumber/Pages/WholeSaleHome/SellProduct/sellBulkMain.dart';
import 'package:plumber/Pages/WholeSaleHome/wholeSale.dart';
import 'package:plumber/Pages/amith.dart';
import 'package:plumber/Pages/chat.dart';
import 'package:plumber/Pages/JobsHome/Jobs/home.dart';
import 'package:plumber/Pages/faq.dart';
import 'package:plumber/Pages/myAds.dart';
import 'package:plumber/Pages/onbord.dart';
import 'package:plumber/Pages/privacy.dart';
import 'package:plumber/Pages/profile.dart';
import 'package:plumber/Pages/register.dart';
import 'package:plumber/Pages/search.dart';
import 'package:plumber/Pages/setup.dart';
import 'package:plumber/Pages/terms.dart';
import 'package:plumber/Pages/welcome.dart';
import 'package:plumber/firebase_options.dart';
import 'package:plumber/global/globalValues.dart';
import 'package:plumber/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/JobsHome/Jobs/findJobsHome.dart';
import 'package:firebase_core/firebase_core.dart';

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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => CustomAuthProvider(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Swadhina Mahajana Sabhawa',
          themeMode: ThemeMode.system,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.lightTheme,
          initialRoute: '/welcome',
          routes: {
            '/jobs': (context) => JobSelection(),
            '/products': (context) => ProductSelection(),
            '/services': (context) => ServiceSelection(),
            '/wholesale': (context) => WholeSaleSelection(),

            '/findJobs': (context) => HomePage(),
            '/welcome': (context) => const Welcome(),
            '/onbord': (context) => const Onbord(),
            '/register': (context) => const Register(),
            '/login': (context) => const Login(),
            '/setup': (context) => const Setup(),
            '/amith': (context) => const Amith(),

            //Jobs
            '/findJobsHome': (context) => const FindJobsHome(),
            '/browseJobs': (context) => const BrowseJobs(),
            '/search': (context) => const Search(),
            '/chat': (context) => const ChatPage(),
            '/profile': (context) => const Profile(),
            '/availableJobs': (context) => AvailableJobs(),

            //PostJobs
            '/postJobHome': (context) => const JobPostMainPage(),

            //Services
            '/buyservicesMain': (context) => const buyServicesHomePage(),
            '/sellservicesMain': (context) => const SellServicesMainPage(),

            //products
            '/sellProduct': (context) => const SellProductsMainPage(),
            '/productsMain': (context) => const ProductsHomePage(),

            //products
            '/sellBulk': (context) => const SellBulksMainPage(),
            '/buyBulk': (context) => const BulkMainPage(),

            //profile
            '/privacy': (context) => PrivacyPolicy(),
            '/terms': (context) => TermsCondition(),
            '/faq': (context) => FaQ(),
            '/myads': (context) => MyAds(),
          },
        ));
  }
}
