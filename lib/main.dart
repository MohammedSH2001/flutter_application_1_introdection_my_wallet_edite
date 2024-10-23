import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/data/getdatahive.dart';
import 'package:flutter_application_1_introdection_my_wallet/firebase_options.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/auth/login.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/introduction/Bording.dart';
import 'package:flutter_application_1_introdection_my_wallet/theme/theme_provider.dart';
import 'package:flutter_application_1_introdection_my_wallet/widgat/Bottun.dart';
import 'package:flutter_application_1_introdection_my_wallet/widgat/snackbar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(AdddataAdapter());
  await Hive.openBox<Add_data>("data");
// await FirebaseNatification().initNotification();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await Hive.initFlutter();
//   Hive.registerAdapter(AdddataAdapter());
//   await Hive.openBox<Add_data>("data");
//   // await FirebaseNatification().initNotification();

//   runApp(
//     DevicePreview(
//       enabled: !kReleaseMode, // Enable Device Preview only in debug mode
//       builder: (context) => ChangeNotifierProvider(
//         create: (context) => ThemeProvider(),
//         child: const MyApp(),
//       ),
//     ),
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).themeData,
        home: //يدير اتصال بين التطبيق والفايربيس  ويتحقق اذا كان فيه بيانات او لا
            StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, Snapshot) {
                  if (Snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  } else if (Snapshot.hasError) {
                    return showSnackBar(context, "Something went wrong");
                  } else if (Snapshot.hasData) {
                    return BottunMy();
                  } else {
                    return BordingScreen();
                  }
                }));
  }
}
