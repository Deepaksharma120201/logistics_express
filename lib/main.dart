import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_express/src/custom_widgets/handling_controller.dart';
import 'package:logistics_express/src/features/screens/splash_screen.dart';
import 'package:logistics_express/src/services/authentication/auth_controller.dart';
import 'package:logistics_express/src/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  String appId = dotenv.env['ONESIGNAL_APP_ID']!;
  OneSignal.initialize(appId);
  OneSignal.Notifications.requestPermission(false);

  await Firebase.initializeApp();

  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      // navigatorObservers: [ClearControllerObserver(ref)],
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: SplashScreen(),
    );
  }
}

// class ClearControllerObserver extends NavigatorObserver {
//   final WidgetRef ref;
//   ClearControllerObserver(this.ref);

//   @override
//   void didPop(Route route, Route? previousRoute) {
//     super.didPop(route, previousRoute);

//     if (ref.read(datePickerStateProvider) || ref.read(dropdownStateProvider)) {
//       return;
//     }

//     final authController = ref.read(authControllerProvider);
//     authController.clearAll();
//   }
// }
