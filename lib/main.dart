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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        // fontFamily: "Montserrat",
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => MapCubit(),
        child: const MapScreen(),
      ),
    );
  }
}
