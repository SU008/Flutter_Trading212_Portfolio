import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../data_models/open_positions_model.dart';

//--------------Events
@immutable
abstract class ApiOpenPositionsEvent {}

class FetchDataOpenPositionsEvent extends ApiOpenPositionsEvent {}
//-------------------------------------

//--------------States
@immutable
abstract class ApiOpenPositionsState {}

class InitialState extends ApiOpenPositionsState {}

class LoadingState3 extends ApiOpenPositionsState {}

class DataLoadedOpenPositionsState extends ApiOpenPositionsState {
  final OpenPositionsList data;

  DataLoadedOpenPositionsState(this.data);
}

class ErrorState2 extends ApiOpenPositionsState {
  final String error;

  ErrorState2(this.error);
}
//--------------------------

// BLoC
class ApiOpenPositionsBloc extends Bloc<ApiOpenPositionsEvent, ApiOpenPositionsState> {


  ApiOpenPositionsBloc() : super(InitialState()) {
    // Register the event handler for FetchDataEvent
    on<FetchDataOpenPositionsEvent>(_onFetchDataOpenPositionsEvent);
  }

  // Event handler for FetchDataEvent
  void _onFetchDataOpenPositionsEvent(FetchDataOpenPositionsEvent event,
      Emitter<ApiOpenPositionsState> emit) async {
    emit(LoadingState3());

    await Future.delayed(const Duration(milliseconds: 5000),);

    await dotenv.load(); //done in main.dart instead
    String tempAPI_key = dotenv.env['API_KEY'] ?? "Your_API_Key_During_Testing";


    var targetHeaders = {
      "Authorization": tempAPI_key,
      "Content-Type": "application/json",
    };

    Uri theUrl = Uri.parse(
        'https://live.trading212.com/api/v0/equity/portfolio');


    final response = await http.get(
        theUrl, headers: targetHeaders); //sending a get
    print('Open Positions response code: ${response.statusCode}');

    try {
      if (response.statusCode == 200) {
        // Decode the JSON response into an instance of AccountCash

        //List<Map<String, dynamic>> data = json.decode(response.body);

        OpenPositionsList myOpenposition = OpenPositionsList.fromJson(json.decode(response.body));

        //final Map<String, dynamic> data = json.decode(response.body);
        print("OpenPositions map data: ${myOpenposition}");


        emit(DataLoadedOpenPositionsState(myOpenposition));
      } else {
        print('failed to fetch data');
        throw Exception("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      print('failed to fetch data [e]');

      print("Error decoding JSON or handling response: $e");
    }
  }



}
