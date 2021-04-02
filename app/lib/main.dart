import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import 'app.dart';

void main() async {
  await DotEnv.load();
  
  runApp(App());
}