import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assist/flutter_assist.dart';
import 'package:scaled_app/scaled_app.dart';

import 'src/alert/alert.dart';
import 'src/usm-demo/usm_demo.flow.dart';
import 'src/usm-demo/usm_demo.view.dart';

void main() async {
  LogUtil.init();

  LogUtil.devLog("main", message: "Initializing Scaled App");
  ScaledWidgetsFlutterBinding.ensureInitialized(
    scaleFactor: (deviceSize) {
      // screen width used in your UI design
      const double widthOfDesign = 1920;
      return deviceSize.width / widthOfDesign;
    },
  );
  //? Then, use MediaQueryData.scale to scale size, viewInsets, viewPadding, etc.
  //* class PageRoute extends StatelessWidget {
  //*   const PageRoute({Key? key}) : super(key: key);

  //*   @override
  //*   Widget build(BuildContext context) {
  //*     return MediaQuery(
  //*       data: MediaQuery.of(context).scale(),
  //*       child: const Scaffold(...),
  //*     );
  //*   }
  //* }

  // Animate.restartOnHotReload =
  //     true; //? This makes all animations from flutter_animate restart on hot reload

  LogUtil.devLog("main", message: "Running app");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        }
      },
      child: AlertWrapper(
        app: MaterialApp(
          title: 'USM Demo',
          debugShowCheckedModeBanner: false,
          home: UsmDemoView(
            key: GlobalKey(),
            flow: UsmDemoFlow(),
          ),
        ),
      ),
    );
  }
}
