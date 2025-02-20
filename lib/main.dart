import 'package:flutter/material.dart';
import 'package:visualizador_charts/data/data_sources/local_data_source.dart';
import 'package:visualizador_charts/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await localDataSource.initialization();
  runApp(const MainApp());
}
