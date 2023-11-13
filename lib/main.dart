import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; //for env
import 'package:flutter_portfolio_dividend/screens/homescreen.dart';
import 'package:flutter_portfolio_dividend/services/T212_API_Bloc/t212_api_bloc.dart';


void main()  {


  WidgetsFlutterBinding.ensureInitialized();

  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => T212ApiBloc(),
        child: MyHomePage(),
      ),
    );
  }
}