import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/config/build_mode.dart';
import 'package:swing_share/infra/model/video_path_ref.dart';
import 'package:swing_share/presentation/base_page.dart';

import 'gen/firebase_options_development.dart' as development;
import 'gen/firebase_options_production.dart' as production;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: development.DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(VideoPathRefAdapter());

  final box = await Hive.openBox('pathRefBox');
  log('box.values: ${box.values.toList()}');

  log('buildMode: $buildMode');
  runApp(const ProviderScope(
    child: App(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swing Share',
      builder: EasyLoading.init(),
      theme: ThemeData(brightness: Brightness.dark),
      home: const BasePage(),
    );
  }
}

FirebaseOptions getFirebaseOptions() {
  const flavor = String.fromEnvironment('FLAVOR');
  switch (flavor) {
    case 'development':
      return development.DefaultFirebaseOptions.currentPlatform;
    case 'production':
      return production.DefaultFirebaseOptions.currentPlatform;
    default:
      throw ArgumentError('Not available flavor');
  }
}
