import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_search/features/map/logic/map_cubit.dart';
import 'package:map_search/features/map/ui/map_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences sp;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sp = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: MediaQuery.textScalerOf(
              context,
            ).clamp(minScaleFactor: 1, maxScaleFactor: 1),
          ),
          child: child!,
        );
      },
      home: BlocProvider(
        create: (context) => MapCubit(),
        child: const MapScreen(),
      ),
    );
  }
}
