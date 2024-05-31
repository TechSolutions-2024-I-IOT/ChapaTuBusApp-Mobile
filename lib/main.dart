import 'package:chapa_tu_bus_app/account_management/infrastructure/data/local_database_datasource.dart';
import 'package:chapa_tu_bus_app/shared/router/app_router.dart';
import 'package:chapa_tu_bus_app/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'execution_monitoring/presentation/blocs/blocs.dart';
import 'firebase_options.dart';
import './injections.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  final database = LocalDatabaseDatasource.instance;

  final users = await database.getAllUsers();

  if (users.isEmpty) {
    print('La base de datos está vacía.');
  } else {
    print('La base de datos tiene ${users.length} usuarios.');
  }
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GpsBloc()),
      ], 
      child: const MainApp()
    )
  );

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      title: 'ChapaTuBus',
      theme: AppTheme().getTheme(),
    );
  }
}
