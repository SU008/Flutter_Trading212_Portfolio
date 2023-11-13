import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';

import '../../data_models/historical_dividends_model.dart';


part 't212_dividend_event.dart';
part 't212_dividend_state.dart';

class T212DividendBloc extends Bloc<T212DividendEvent, T212DividendState> {
  T212DividendBloc() : super(T212DividendInitial()) {

    on<GetPaidOutDividendsEventModel2>(_getPaidOutDividendsEventModel2);
  }

  void _getPaidOutDividendsEventModel2(GetPaidOutDividendsEventModel2 event, Emitter<T212DividendState> emit) async {
    emit(LoadingState2());

    await dotenv.load(); //done in main.dart instead
    String tempAPI_key = dotenv.env['API_KEY'] ?? "Your_API_Key_During_Testing";

    Map<String, String> queryParameters = {
      "limit": "50",
    };

    var target_headers = {
      "Authorization": tempAPI_key,
      "Content-Type":"application/json",
    };

    Uri theUrl = Uri.parse('https://live.trading212.com/api/v0/history/dividends').replace(queryParameters: queryParameters);

    print('the url is : $theUrl');
    final response = await http.get(theUrl, headers: target_headers); //sending a get
    print('dividends response code: ${response.statusCode}');

    try {
      if (response.statusCode == 200) {
        // Decode the JSON response into an instance of AccountCash

        Map<String, dynamic> data = json.decode(response.body);

        HistoricalDividends divhistory = HistoricalDividends.fromJson( json.decode(response.body));

        //final Map<String, dynamic> data = json.decode(response.body);
        print("Dividend map data: ${data}");
        print("Dividend map data: ${divhistory.items}");

        emit(PaidOutDividendsStateModel2(divhistory));

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
