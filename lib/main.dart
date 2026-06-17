import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:girlified/core/middlewares/core.dart';
import 'package:girlified/core/constants/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:girlified/data/repositories/index.dart';
import 'package:girlified/core/themes/theme_provider.dart';
import 'package:girlified/data/services/text_detection_pipeline.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  await dotenv.load(fileName: ".env");

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  final updateService = AppUpdateService();

  updateService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  RxBool isLoading = false.obs;
  GetStorage localStorage = GetStorage();
  String initialRoute = AppRoutes.rootRoute;

  final ThemeProvider themeProvider = Get.put(ThemeProvider());
  final RootRepository rootRepository = Get.put(RootRepository());

  @override
  void initState() {
    rootRepository.initialize();
    TextDetectionPipeline.instance.start();
    super.initState();
  }

  @override
  void dispose() {
    TextDetectionPipeline.instance.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'girlified',
      themeMode: ThemeMode.dark,
      initialRoute: initialRoute,
      getPages: AppRoutes.routes,
      theme: themeProvider.themeData,
      debugShowCheckedModeBanner: false,
    );
  }
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SizedBox.shrink(),
    ),
  );
}
